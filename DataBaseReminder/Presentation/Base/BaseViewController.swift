//
//  BaseViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit

class BaseViewController<CustomView: BaseView>: UIViewController {
    
    let customView: CustomView
    
    init(view: CustomView) {
        self.customView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() { }
}
