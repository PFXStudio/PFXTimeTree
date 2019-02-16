//
//  EventModel.swift
//  PFXTimeTree
//
//  Created by PFXStudio on 2019. 2. 16..
//  Copyright © 2019년 PFXStudio. All rights reserved.
//

import UIKit

struct EventModel: Decodable {
    var title = ""
    var startDate: Date
    var endDate: Date
    enum CodingKeys: String, CodingKey {
        case title
        case startDate = "start"
        case endDate = "end"
    }
    
    lazy var startYear: Int = {
        let calendar = Calendar.current
        return calendar.component(.year, from: self.startDate)
    }()
    
    lazy var startMonth: Int = {
        let calendar = Calendar.current
        return calendar.component(.month, from: self.startDate)
    }()
    
    lazy var startDay: Int = {
        let calendar = Calendar.current
        return calendar.component(.day, from: self.startDate)
    }()
    
    lazy var startHour: Int = {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self.startDate)
    }()
    
    lazy var startMinute: Int = {
        let calendar = Calendar.current
        return calendar.component(.minute, from: self.startDate)
    }()
    
    lazy var endYear: Int = {
        let calendar = Calendar.current
        return calendar.component(.year, from: self.endDate)
    }()
    
    lazy var endMonth: Int = {
        let calendar = Calendar.current
        return calendar.component(.month, from: self.endDate)
    }()
    
    lazy var endDay: Int = {
        let calendar = Calendar.current
        return calendar.component(.day, from: self.endDate)
    }()
    
    lazy var endHour: Int = {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self.endDate)
    }()
    
    lazy var endMinute: Int = {
        let calendar = Calendar.current
        return calendar.component(.minute, from: self.endDate)
    }()
    
    lazy var totalDayMinute: (Int, Int) = {
        let totalStartMin = (self.startHour * 60) + self.startMinute
        // End는 그 시간까지 한다는 거기 때문에 1을 빼줌
        let totalEndMin = (self.endHour * 60) + (self.endMinute - 1)
        return (totalStartMin, totalEndMin)
    }()
    
    /*
     "title": "Nap Break",
     "start": "November 8, 2017 12:30 PM",
     "end": "November 8, 2017 1:30 PM"
     */

}
