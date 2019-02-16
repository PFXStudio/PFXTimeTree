//
//  EventViewController.swift
//  PFXTimeTree
//
//  Created by PFXStudio on 2019. 2. 15..
//  Copyright © 2019년 PFXStudio. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    var eventDate: Date?

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bgndView: UIView!
    @IBOutlet weak var lineLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bgndView.roundLayer(withValue: DefaultTheme.roundValue)
        self.bgndView.shadow(withValue: DefaultTheme.shadowValue)
        
        /*
         
         let dateFormatter = DateFormatter()
         dateFormatter.locale = Locale(identifier: "ko_kr")
         dateFormatter.dateFormat = "yyyy-MM-dd(EEEE)"
         dateFormatter.string(from: self.eventDate!)
         self.dateLabel.text = dateFormatter.string(from: self.eventDate!)
         */
        let localText = self.eventDate?.description(with: Locale(identifier: "ko_KR"))
        guard let tokens = localText?.components(separatedBy: "오전") else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            self.dateLabel.text = dateFormatter.string(from: self.eventDate!)
            return
        }
        
        self.dateLabel.text = tokens[0]
    }
    
    @IBAction func touchedBgndButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchedAddButton(_ sender: Any) {
        let identifier = "\(EventRegistViewController.self)"
        guard let eventRegistViewController = UIStoryboard.init(name: "Event", bundle: nil).instantiateViewController(withIdentifier: identifier) as? EventRegistViewController else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        
        let dateString = dateFormatter.string(from: self.eventDate!)
        
        eventRegistViewController.targetDate = dateFormatter.date(from: dateString)!
        eventRegistViewController.modalPresentationStyle = .overCurrentContext
        self.present(eventRegistViewController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? EventTableViewController {
            destination.key = EventManager.generateKey(date: self.eventDate)
        }
    }
}
