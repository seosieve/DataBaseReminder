//
//  TagView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit
import SnapKit

class TagView: BaseView {
    
    let tagTextField = {
        let textField = UITextField()
        textField.tintColor = Colors.contentBlue
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "태그를 입력하세요", attributes: [.foregroundColor: Colors.descriptionBlack])
        return textField
    }()
    
    override func configureView() {
        self.backgroundColor = Colors.subBlack
    }
    
    override func configureSubViews() {
        self.addSubview(tagTextField)
    }
    
    override func configureConstraints() {
        tagTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
}
