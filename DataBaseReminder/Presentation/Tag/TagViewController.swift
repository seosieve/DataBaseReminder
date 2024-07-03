//
//  TagViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit

class TagViewController: BaseViewController {
    
    private let customView: TagView!
    
    private var tag = String()
    
    var transferData: ((String) -> Void)?
    
    init(view: TagView) {
        self.customView = view
        super.init()
    }
    
    override func loadView() {
        self.view = customView
    }
    
    override func configureView() {
        navigationItem.title = "태그"
        customView.tagTextField.addTarget(self, action: #selector(tagChanged(_:)), for: .editingChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        transferData?(tag)
    }
    
    @objc private func tagChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        print(text)
        tag = text
    }
}
