//
//  PriorityView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit
import SnapKit

class PriorityView: BaseView {
    
    let segmentedControl = {
        let items = ["FIRST", "SECOND", "THIRD"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentTintColor = Colors.mainBlue
        control.selectedSegmentIndex = 0
        return control
    }()
    
    override func configureView() {
        self.backgroundColor = Colors.subBlack
    }
    
    override func configureSubViews() {
        self.addSubview(segmentedControl)
    }
    
    override func configureConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
        }
    }
}
