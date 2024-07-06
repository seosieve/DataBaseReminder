//
//  RegisterView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit
import SnapKit

class RegisterView: BaseView {
    
    let cancelButtonItem = {
        let button = UIBarButtonItem()
        button.title = "취소"
        button.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 18)], for: .normal)
        button.tintColor = Colors.contentBlue
        button.style = .plain
        return button
    }()
    
    let addButtonItem = {
        let button = UIBarButtonItem()
        button.title = "추가"
        button.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 18)], for: .normal)
        button.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 18)], for: .disabled)
        button.tintColor = Colors.contentBlue
        button.style = .plain
        button.isEnabled = false
        return button
    }()
    
    private let textContainerView = {
        let view = UIView()
        view.backgroundColor = Colors.contentBlack
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleTextField = {
        let textField = UITextField()
        textField.tag = 0
        textField.font = .systemFont(ofSize: 17)
        textField.tintColor = Colors.contentBlue
        textField.textColor = .white
        let placeHolderColor = Colors.descriptionBlack
        let placeHolderFont = UIFont.systemFont(ofSize: 17)
        textField.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [.foregroundColor: placeHolderColor, .font: placeHolderFont])
        return textField
    }()
    
    private let divider = {
        let view = UIView()
        view.backgroundColor = Colors.descriptionBlack.withAlphaComponent(0.3)
        return view
    }()
    
    let memoTextView = {
        let textView = UITextView()
        textView.tag = 1
        textView.font = .systemFont(ofSize: 17)
        textView.tintColor = Colors.contentBlue
        textView.textColor = Colors.descriptionBlack
        textView.text = "메모"
        textView.backgroundColor = .clear
        return textView
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
        self.hideKeyboardWhenTappedAround()
    }
    
    override func configureSubViews() {
        self.addSubview(textContainerView)
        textContainerView.addSubview(titleTextField)
        textContainerView.addSubview(divider)
        textContainerView.addSubview(memoTextView)
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
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(divider).inset(6)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(20)
        }
        
        registerTableView.snp.makeConstraints { make in
            make.top.equalTo(textContainerView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.navigationItem.title = "새로운 할 일"
        vc.navigationItem.leftBarButtonItem = cancelButtonItem
        vc.navigationItem.rightBarButtonItem = addButtonItem
        vc.navigationController?.navigationBar.tintColor = Colors.mainBlue
    }
}
