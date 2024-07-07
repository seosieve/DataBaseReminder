//
//  CalendarViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/7/24.
//

import UIKit
import FSCalendar

final class CalendarViewController: BaseViewController<CalendarView> {
    
    let repository = ReminderRepository()
    
    override func configureView() {
        ///Configure Nav
        customView.configureNavigationController(self)
        ///FSCalendar
        customView.calendarView.delegate = self
        customView.calendarView.dataSource = self
    }
}

//MARK: - FSCalendarDelegate, FSCalendarDataSource
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let vc = ListViewController(view: ListView())
        vc.navigationItem.title = Date.selectedDay(date: date)
        vc.list = repository.filterObject(date: date)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        customView.headerLabel.text = Date.currentCalendar(date: customView.calendarView.currentPage)
    }
}

