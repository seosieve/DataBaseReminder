//
//  DateViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit

class DateViewController: BaseViewController<DateView>, SubViewType {
    
    private var date = Date.removeTime()
    weak var delegate: DataTransportDelegate?
    
    override func configureView() {
        customView.configureNavigationController(self)
        customView.datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.transportDate(date: date)
    }
    
    @objc private func dateChanged(_ picker: UIDatePicker) {
        self.date = Date.removeTime(date: picker.date)
    }
}
