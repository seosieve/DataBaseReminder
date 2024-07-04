//
//  DateViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit

class DateViewController: BaseViewController<DateView> {
    
    private var date = String()
    
    var transferData: ((String) -> Void)?
    
    override init(view: DateView) {
        super.init(view: view)
    }
    
    override func configureView() {
        navigationItem.title = "마감일"
        customView.datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        transferData?(date)
    }
    
    @objc private func dateChanged(_ picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let dateString = dateFormatter.string(from: picker.date)
        date = dateString
    }
}
