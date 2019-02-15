//
//  EventViewController.swift
//  PFXTimeTree
//
//  Created by PFXStudio on 2019. 2. 15..
//  Copyright © 2019년 PFXStudio. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    var mockModelDict = Dictionary<String, [MockModel]>()
    var eventDate: Date?

    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        /*
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy-MM-dd(EEEE)"
        dateFormatter.string(from: self.eventDate!)
        self.dateLabel.text = dateFormatter.string(from: self.eventDate!)
 */
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ko_KR")
        self.dateLabel.text = dateFormatter.string(from: self.eventDate!)

    }
    
    @IBAction func touchedBgndButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? EventTableViewController {
            let key = DateUtil.generateKey(date: self.eventDate)
            guard let mockModels = self.mockModelDict[key] else {
                return
            }
            
            destination.mockModels = mockModels
        }
    }

}
