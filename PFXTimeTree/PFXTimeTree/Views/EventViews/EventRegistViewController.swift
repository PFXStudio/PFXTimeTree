//
//  EventRegistViewController.swift
//  PFXTimeTree
//
//  Created by PFXStudio on 2019. 2. 16..
//  Copyright © 2019년 PFXStudio. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftyJSON
import SwiftProgressHUD

class EventRegistViewController: UIViewController {
    var targetDate = Date()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var endTimeButton: UIButton!

    var eventModelDict = Dictionary<String, Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.titleTextField.placeholder = NSLocalizedString("titlePlaceholder", comment: "")
        self.titleTextField.title = NSLocalizedString("title", comment: "")
        self.startTimeButton.setTitle(NSLocalizedString("startTimeButtonTitle", comment: ""), for: .normal)
        self.endTimeButton.setTitle(NSLocalizedString("endTimeButtonTitle", comment: ""), for: .normal)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.titleLabel.text = dateFormatter.string(from: self.targetDate)
    }
    
    @IBAction func touchedCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchedRegistButton(_ sender: Any) {
        // generate eventmodel
        if (self.titleTextField.text?.count)! <= 0 {
            SwiftProgressHUD.showFail(NSLocalizedString("errorTitle", comment: ""))
            return
        }
        
        self.eventModelDict["title"] = self.titleTextField.text
        let decoder = JSONDecoder()
        let text = JSON(self.eventModelDict)
        let dateFormatter = DateFormatter.eventModelDateFormatter
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        do {
            let model = try decoder.decode(EventModel.self, from: text.rawData())
            print(EventManager.shared.insertEventModel(eventModel: model))
        }
        catch {
            
        }
        
        SwiftProgressHUD.showSuccess(NSLocalizedString("successRegisted", comment: ""), autoClear: true, autoClearTime: 1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func touchedStartTimeButton(_ sender: Any) {
        self.titleTextField.resignFirstResponder()

        // show time action sheet
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.date = self.targetDate
        let dateChooserAlert = UIAlertController(title: NSLocalizedString("startDatePickerTitle", comment: ""), message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubview(datePicker)
        dateChooserAlert.addAction(UIAlertAction(title: NSLocalizedString("doneButtonTitle", comment: ""), style: .cancel, handler: { [weak self] action in
            // Your actions here if "Done" clicked...
            let dateformatter = DateFormatter.eventModelDateFormatter
            let date = dateformatter.string(from: datePicker.date)
            if let endString = self?.eventModelDict["end"] as? String {
                let endDate = dateformatter.date(from: endString)!
                if datePicker.date.timeIntervalSince1970 >= endDate.timeIntervalSince1970 {
                    SwiftProgressHUD.showFail(NSLocalizedString("errorOverEndTime", comment: ""))
                    return
                }
            }

            self?.startTimeButton.setTitle(date, for: .normal)
            self?.eventModelDict["start"] = date
        }))
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: dateChooserAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 300)
        dateChooserAlert.view.addConstraint(height)
        self.present(dateChooserAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func touchedEndTimeButton(_ sender: Any) {
        self.titleTextField.resignFirstResponder()
        
        // show time action sheet
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.date = self.targetDate
        let dateChooserAlert = UIAlertController(title: NSLocalizedString("endDatePickerTitle", comment: ""), message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubview(datePicker)
        dateChooserAlert.addAction(UIAlertAction(title: NSLocalizedString("doneButtonTitle", comment: ""), style: .cancel, handler: { [weak self] action in
            // Your actions here if "Done" clicked...
            let dateformatter = DateFormatter.eventModelDateFormatter
            let date = dateformatter.string(from: datePicker.date)
            if let startString = self?.eventModelDict["start"] as? String {
                let startDate = dateformatter.date(from: startString)!
                if datePicker.date.timeIntervalSince1970 <= startDate.timeIntervalSince1970 {
                    SwiftProgressHUD.showFail(NSLocalizedString("errorBeforeStartTime", comment: ""))
                    return
                }
            }

            self?.endTimeButton.setTitle(date, for: .normal)
            self?.eventModelDict["end"] = date
        }))
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: dateChooserAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 300)
        dateChooserAlert.view.addConstraint(height)
        self.present(dateChooserAlert, animated: true, completion: nil)
    }
    
    @IBAction func touchedBgndView(_ sender: Any) {
        self.titleTextField.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
