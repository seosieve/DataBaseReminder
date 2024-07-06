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
        let control = UISegmentedControl(items: Names.priorityNames.allCases.map{String(describing: $0)})
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([.foregroundColor: Colors.descriptionBlack], for: .normal)
        control.selectedSegmentTintColor = Colors.contentBlue
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
            make.width.equalTo(350)
            make.height.equalTo(36)
        }
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.navigationItem.title = "우선 순위"
    }
}
