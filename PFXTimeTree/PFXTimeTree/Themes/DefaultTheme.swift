//
//  DefaultTheme.swift
//  PFXTimeTree
//
//  Created by PFXStudio on 2019. 2. 15..
//  Copyright © 2019년 PFXStudio. All rights reserved.
//

import UIKit

struct DefaultTheme {
    static let selectedText = UIColor.white
    static let text = UIColor.black
    static let textDisabled = UIColor.gray
    static let selectionBackground = UIColor(red: 250/255, green: 128/255, blue: 114/255, alpha: 1.0)
    static let sundayText = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
    static let sundayTextDisabled = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
    static let sundaySelectionBackground = sundayText
    static let circleColor = UIColor(red: 255/255, green: 159/255, blue: 67/255, alpha: 1.0)
    static let validColor = UIColor(red: 29/255, green: 209/255, blue: 161/255, alpha: 1.0)
    static let conflictColor = UIColor(red: 238/255, green: 82/255, blue: 83/255, alpha: 1.0)
    static let roundValue: CGFloat = 5.0
    static let shadowValue: CGFloat = 5.0
}
