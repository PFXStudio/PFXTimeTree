//
//  EventManager.swift
//  PFXTimeTree
//
//  Created by PFXStudio on 2019. 2. 16..
//  Copyright © 2019년 PFXStudio. All rights reserved.
//

import UIKit

class EventManager: NSObject {
    var dict = Dictionary<String, [EventModel]>()
    var timeDict = Dictionary<String, [Int]>()
    
    static let shared = EventManager()
    var completedInitialize = false
    
    func initialize() {
        guard let path = Bundle.main.path(forResource: "mock", ofType: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter.eventModelDateFormatter
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let models = try decoder.decode([EventModel].self, from: data)
            for i in models.indices {
                if self.insertEventModel(eventModel: models[i]) == true {
                    self.checkConflict(eventModel: models[i])
                }
            }
        }
        catch {
            assert(false, "Error mock.json parse")
        }
        
        
        self.completedInitialize = true
    }
    
    func eventModels(date: Date?) -> [EventModel]? {
        guard let eventDate = date else {
            return []
        }
        
        let key = EventManager.generateKey(date: eventDate)
        return self.dict[key]
    }

    func checkConflict(eventModel: EventModel) {
        for key in self.dict.keys {
            let eventModels = self.dict[key]!
            if self.timeDict[key] != nil {
                self.timeDict[key]?.removeAll()
            }
            var times = Array(repeating: 0, count: 60 * 24)

            for i in 0..<eventModels.count {
                var eventModel = eventModels[i]
                let (totalStartMin, totalEndMin) = eventModel.totalDayMinute
                assert(totalStartMin < totalEndMin, "wrong totalEndMin")
                // 시작 분부터 끝나는 분까지의 값을 키 값으로 하여 배열화 함
                for x in totalStartMin...totalEndMin {
                    times[x] = times[x] + 1
                }
            }

            self.timeDict[key] = times
        }
    }
    
    func insertEventModel(eventModel:EventModel) -> Bool{
        let key = EventManager.generateKey(date: eventModel.startDate)
        if self.dict[key] == nil {
            self.dict[key] = [EventModel]()
        }

        self.dict[key]!.append(eventModel)
        self.dict[key] = self.dict[key]!.sorted(by: { (l, r) -> Bool in
            let leftModel = l
            let rightModel = r
            
            return leftModel.startDate.timeIntervalSince1970 < rightModel.startDate.timeIntervalSince1970
        })

        self.checkConflict(eventModel: eventModel)
        
        if self.completedInitialize == false {
            return true
        }
        
        // RxSwift를 활용해 보고 싶은 부분입니다.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateEvents"), object: eventModel)
        return true
    }
    
    static func generateKey(date: Date?) -> String {
        if date == nil {
            return ""
        }
        
        guard let checkDate = date else {
            return ""
        }
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: checkDate)
        let month = calendar.component(.month, from: checkDate)
        let day = calendar.component(.day, from: checkDate)
        return String("\(year)/\(month)/\(day)")
    }
    
    func isConflict(eventModel: EventModel?) -> Bool {
        guard var model = eventModel else {
            return false
        }
        
        let key = EventManager.generateKey(date: model.startDate)
        let (startTotalMin, endTotalMin) = model.totalDayMinute
        let times = timeDict[key]!
        for i in startTotalMin...endTotalMin {
            if times[i] > 1 {
                return true
            }
        }
        
        return false
    }
}
