//
//  ExtensionDateFormatter.swift
//  PFXTimeTree
//
//  Created by PFXStudio on 2019. 2. 16..
//  Copyright © 2019년 PFXStudio. All rights reserved.
//

import UIKit

extension DateFormatter {
    static let eventModelDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy h:mm a"
        formatter.locale = Locale(identifier: "en")

        return formatter
    }()
}

