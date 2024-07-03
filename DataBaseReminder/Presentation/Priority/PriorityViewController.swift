//
//  PriorityViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit

class PriorityViewController: BaseViewController {
    
    private let customView: PriorityView!
    
    private var priority = "0"
    
    var transferData: ((String) -> Void)?
    
    init(view: PriorityView) {
        self.customView = view
        super.init()
    }
    
    override func loadView() {
        self.view = customView
    }
    
    override func configureView() {
        navigationItem.title = "우선 순위"
        customView.segmentedControl.addTarget(self, action: #selector(priorityChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        transferData?(priority)
    }
    
    @objc private func priorityChanged(_ sender: UISegmentedControl) {
        priority = String(sender.selectedSegmentIndex)
    }
}
