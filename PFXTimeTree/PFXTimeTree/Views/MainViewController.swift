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
    
    private var randomNumberOfDotMarkersForDay = [Int]()
    private var shouldShowDaysOut = true
    private var animationFinished = true
    private var selectedDay: DayView!
    private var currentCalendar: Calendar?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let path = Bundle.main.path(forResource: "mock", ofType: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let datas = try JSONDecoder().decode([MockModel].self, from: data)
            print(datas)
        }
        catch {
            assert(false, "Error mock.json parse")
        }
        
        // Appearance delegate [Unnecessary]
        self.calendarView.calendarAppearanceDelegate = self
        
        // Animator delegate [Unnecessary]
        self.calendarView.animatorDelegate = self
        
        // Menu delegate [Required]
        self.calendarMenuView.menuViewDelegate = self
        
        // Calendar delegate [Required]
        self.calendarView.calendarDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.calendarMenuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func presentationMode() -> CalendarMode {
        return CalendarMode.monthView
    }
    
    func firstWeekday() -> Weekday {
        return Weekday.sunday
    }
    
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


