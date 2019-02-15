//
//  DateUtil.swift
//  PFXTimeTree
//
//  Created by PFXStudio on 2019. 2. 15..
//  Copyright © 2019년 PFXStudio. All rights reserved.
//

import UIKit

class DateUtil: NSObject {
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
}
