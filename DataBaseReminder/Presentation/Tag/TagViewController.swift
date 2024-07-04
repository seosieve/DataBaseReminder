//
//  TagViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit

class TagViewController: BaseViewController<TagView> {
    
    private var tag = String()
    
    var transferData: ((String) -> Void)?
    
    override init(view: TagView) {
        super.init(view: view)
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
