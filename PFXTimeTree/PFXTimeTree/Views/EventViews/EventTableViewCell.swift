//
//  EventTableViewCell.swift
//  PFXTimeTree
//
//  Created by PFXStudio on 2019. 2. 16..
//  Copyright © 2019년 PFXStudio. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var conflictLabel: UILabel!
    
    static let s_height: CGFloat = 55
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialize() {
        self.startTimeLabel.text = ""
        self.endTimeLabel.text = ""
        self.titleLabel.text = ""
        self.conflictLabel.backgroundColor = DefaultTheme.validColor
    }
    
    func update(eventModel: EventModel, conflicted: Bool) {
        self.initialize()
        
        var model = eventModel
        self.titleLabel.text = model.title
        var startAm = NSLocalizedString("am", comment: "")
        var startHour = model.startHour
        if model.startHour >= 12 {
            startAm = NSLocalizedString("pm", comment: "")
            startHour = startHour > 12 ? startHour - 12 : startHour
        }

        var endAm = NSLocalizedString("am", comment: "")
        var endHour = model.endHour
        if model.endHour >= 12 {
            endAm = NSLocalizedString("pm", comment: "")
            endHour = endHour > 12 ? endHour - 12 : endHour
        }
        
        if conflicted == true {
            self.conflictLabel.backgroundColor = DefaultTheme.conflictColor
        }

        self.startTimeLabel.text = String("\(startAm) \(startHour):\(model.startMinute < 10 ? "0" : "")\(model.startMinute)")
        self.endTimeLabel.text = String("\(endAm) \(endHour):\(model.endMinute < 10 ? "0" : "")\(model.endMinute)")
    }
}
