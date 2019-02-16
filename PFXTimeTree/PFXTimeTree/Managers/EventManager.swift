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
    
    func eventModels(date: Date?) -> [EventModel]? {
        guard let eventDate = date else {
            return []
        }
        
        let key = EventManager.generateKey(date: eventDate)
        return self.dict[key]
    }

    func checkConflict() {
        self.timeDict.removeAll()
        // check conflict
        for key in self.dict.keys {
            let eventModels = self.dict[key]!
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
