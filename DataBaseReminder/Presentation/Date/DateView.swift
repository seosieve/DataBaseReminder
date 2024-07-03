//
//  DateView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit
import SnapKit

class DateView: BaseView {
    
    let datePicker = {
        let picker = UIDatePicker()
        picker.tintColor = .white
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.textColor = Colors.mainBlue
        return picker
    }()
    
    override func configureView() {
        self.backgroundColor = Colors.subBlack
    }
    
    override func configureSubViews() {
        self.addSubview(datePicker)
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints { make in
            make.center.horizontalEdges.equalToSuperview()
        }
    }
}
