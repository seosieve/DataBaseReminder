//
//  RegisterView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit
import SnapKit

class RegisterView: BaseView {
    
    private let textContainerView = {
        let view = UIView()
        view.backgroundColor = Colors.contentBlack
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleTextField = {
        let textField = UITextField()
        textField.tag = 0
        textField.tintColor = Colors.contentBlue
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [.foregroundColor: Colors.descriptionBlack])
        return textField
    }()
    
    private let divider = {
        let view = UIView()
        view.backgroundColor = Colors.descriptionBlack.withAlphaComponent(0.3)
        return view
    }()
    
    let memoTextField = {
        let textField = UITextField()
        textField.tag = 1
        textField.tintColor = Colors.contentBlue
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "메모", attributes: [.foregroundColor: Colors.descriptionBlack])
        return textField
    }()
    
    let registerTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(RegisterTableViewCell.self, forCellReuseIdentifier: RegisterTableViewCell.identifier)
        return tableView
    }()
    
    override func configureView() {
        self.backgroundColor = Colors.subBlack
    }
    
    override func configureSubViews() {
        self.addSubview(textContainerView)
        textContainerView.addSubview(titleTextField)
        textContainerView.addSubview(divider)
        textContainerView.addSubview(memoTextField)
        self.addSubview(registerTableView)
    }
    
    override func configureConstraints() {
        textContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(4)
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(divider).inset(6)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        registerTableView.snp.makeConstraints { make in
            make.top.equalTo(textContainerView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
