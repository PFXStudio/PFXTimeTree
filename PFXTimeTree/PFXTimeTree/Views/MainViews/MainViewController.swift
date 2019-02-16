//
//  MainViewController.swift
//  PFXTimeTree
//
//  Created by PFXStudio on 2019. 2. 15..
//  Copyright © 2019년 PFXStudio. All rights reserved.
//

import UIKit
import CVCalendar

class MainViewController: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    @IBOutlet weak var monthLabel: UILabel!
    
    private var eventDays = [Int]()
    private var shouldShowDaysOut = true
    private var animationFinished = true
    private var selectedDay: DayView!
    private var currentCalendar: Calendar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        EventManager.shared.initialize()
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        components.month = 11
        components.year = 2017
        let date = Calendar.current.date(from: components)
        self.currentCalendar = Calendar.current
        
        // change 2017-11-01
        self.calendarView.toggleViewWithDate(date!)
        
        // RxSwift를 활용해 보고 싶은 부분입니다.
        NotificationCenter.default.addObserver(self, selector: #selector(changedEventModels(_ :)), name: NSNotification.Name(rawValue: DefineStrings.kUpdateEventNotification), object: nil)
    }
    
    @objc func changedEventModels(_ n:Any) {
        // RxSwift를 활용해 보고 싶은 부분입니다.
        self.calendarView.contentController.refreshPresentedMonth()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.calendarMenuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }

/*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
*/
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectedDay = dayView
        
        let identifier = "\(EventViewController.self)"
        guard let eventViewController = UIStoryboard.init(name: "Event", bundle: nil).instantiateViewController(withIdentifier: identifier) as? EventViewController else {
            return
        }
        
        eventViewController.modalPresentationStyle = .overCurrentContext
        eventViewController.modalTransitionStyle = .crossDissolve
        eventViewController.eventDate = self.selectedDay.date.convertedDate()
        self.present(eventViewController, animated: true, completion: nil)
    }

    func presentationMode() -> CalendarMode {
        return CalendarMode.monthView
    }
    
    func firstWeekday() -> Weekday {
        return Weekday.sunday
    }
    
    @IBAction func touchedPreviousButton(_ sender: Any) {
        self.calendarView.loadPreviousView()
    }
    
    @IBAction func touchedNextButton(_ sender: Any) {
        self.calendarView.loadNextView()
    }
    
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        var shouldDisplay = false
        let key = EventManager.generateKey(date: dayView.date.convertedDate())
        if EventManager.shared.dict[key] != nil {
            shouldDisplay = true
        }
        
        return shouldDisplay
    }

/* 이 부분부터는 오픈 소스 코드 입니다. */
/* 이 부분부터는 오픈 소스 코드 입니다. */
/* 이 부분부터는 오픈 소스 코드 입니다. */

    func presentedDateUpdated(_ date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransform(translationX: 0, y: offset)
            updatedMonthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
            
            UIView.animate(withDuration: 0.35, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
                self.monthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransform.identity
                
            }) { _ in
                
                self.animationFinished = true
                self.monthLabel.frame = updatedMonthLabel.frame
                self.monthLabel.text = updatedMonthLabel.text
                self.monthLabel.transform = CGAffineTransform.identity
                self.monthLabel.alpha = 1
                updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
    
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        
        dayView.setNeedsLayout()
        dayView.layoutIfNeeded()
        
        let π = Double.pi
        
        let ringLayer = CAShapeLayer()
        let ringLineWidth: CGFloat = 4.0
        let ringLineColour = DefaultTheme.circleColor
        
        let newView = UIView(frame: dayView.frame)
        
        let diameter = (min(newView.bounds.width, newView.bounds.height))
        let radius = diameter / 2.0 - ringLineWidth
        
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.cgColor
        
        let centrePoint = CGPoint(x: newView.bounds.width/2.0, y: newView.bounds.height/2.0)
        let startAngle = CGFloat(-π/2.0)
        let endAngle = CGFloat(π * 2.0) + startAngle
        let ringPath = UIBezierPath(arcCenter: centrePoint,
                                    radius: radius,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
        
        ringLayer.path = ringPath.cgPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    func shouldAutoSelectDayOnMonthChange() -> Bool { return false }
}

extension MainViewController: CVCalendarViewAppearanceDelegate {
    
    func dayLabelWeekdayDisabledColor() -> UIColor { return .lightGray }
    
    func dayLabelPresentWeekdayInitallyBold() -> Bool { return false }
    
    func spaceBetweenDayViews() -> CGFloat { return 0 }
    
    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont { return UIFont.systemFont(ofSize: 14) }
    
    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _): return DefaultTheme.selectedText
        case (.sunday, .in, _): return DefaultTheme.sundayText
        case (.sunday, _, _): return DefaultTheme.sundayTextDisabled
        case (_, .in, _): return DefaultTheme.text
        default: return DefaultTheme.textDisabled
        }
    }
    
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (.sunday, .selected, _), (.sunday, .highlighted, _): return DefaultTheme.sundaySelectionBackground
        case (_, .selected, _), (_, .highlighted, _): return DefaultTheme.selectionBackground
        default: return nil
        }
    }
}

extension MainViewController {
    func toggleMonthViewWithMonthOffset(offset: Int) {
        guard let currentCalendar = currentCalendar else { return }
        
        var components = Manager.componentsForDate(Date(), calendar: currentCalendar) // from today
        
        components.month! += offset
        
        let resultDate = currentCalendar.date(from: components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
    }
    
    
    func didShowNextMonthView(_ date: Date) {
        guard let currentCalendar = currentCalendar else { return }
        
        let components = Manager.componentsForDate(date, calendar: currentCalendar) // from today
        
        print("Showing Month: \(components.month!)")
    }
    
    
    func didShowPreviousMonthView(_ date: Date) {
        guard let currentCalendar = currentCalendar else { return }
        
        let components = Manager.componentsForDate(date, calendar: currentCalendar) // from today
        
        print("Showing Month: \(components.month!)")
    }
    
    func didShowNextWeekView(from startDayView: DayView, to endDayView: DayView) {
        print("Showing Week: from \(startDayView.date.day) to \(endDayView.date.day)")
    }
    
    func didShowPreviousWeekView(from startDayView: DayView, to endDayView: DayView) {
        print("Showing Week: from \(startDayView.date.day) to \(endDayView.date.day)")
    }
}

/* 이 부분까지 오픈 소스 코드 입니다. */
/* 이 부분까지 오픈 소스 코드 입니다. */
/* 이 부분까지 오픈 소스 코드 입니다. */
