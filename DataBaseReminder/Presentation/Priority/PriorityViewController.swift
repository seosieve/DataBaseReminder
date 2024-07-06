//
//  PriorityViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit

class PriorityViewController: BaseViewController<PriorityView>, SubViewType {
    
    private var priority: Int?
    var delegate: DataTransportDelegate?
    
    override func configureView() {
        customView.configureNavigationController(self)
        customView.segmentedControl.addTarget(self, action: #selector(priorityChanged), for: .valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.transportPriority(priority: priority)
    }
    
    @objc private func priorityChanged(_ sender: UISegmentedControl) {
        priority = sender.selectedSegmentIndex
    }
}
