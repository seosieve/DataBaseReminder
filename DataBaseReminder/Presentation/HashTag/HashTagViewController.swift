//
//  HashTagViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit

class HashTagViewController: BaseViewController<HashTagView>, SubViewType {
    
    private var hashTag: String?
    var delegate: DataTransportDelegate?
    
    override func configureView() {
        customView.configureNavigationController(self)
        customView.tagTextField.addTarget(self, action: #selector(hashTagChanged), for: .editingChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.transportHashTag(hashTag: hashTag)
    }
    
    @objc private func hashTagChanged(_ textField: UITextField) {
        guard let hashTag = textField.text else { return }
        self.hashTag = hashTag
    }
}
