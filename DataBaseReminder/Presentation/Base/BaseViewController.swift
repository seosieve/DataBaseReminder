//
//  BaseViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("addd")
        configureView()
    }
    
    func configureView() { }
}
