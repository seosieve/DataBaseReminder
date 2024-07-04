//
//  RegisterViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit
import RealmSwift

class RegisterViewController: BaseViewController<RegisterView> {
    
    let realm = try! Realm()
    
    var textArr = ["", ""]
    
    var date: Date?
    
    var transferData: (() -> Void)?
    
    var list = ["", "", "", ""] {
        didSet { self.customView.registerTableView.reloadData() }
    }
    
    lazy var cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonPressed))
    
    lazy var addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonPressed))
    
    override init(view: RegisterView) {
        super.init(view: view)
    }
    
    override func configureView() {
        navigationItem.title = "새로운 할 일"
        
        addButton.isEnabled = false
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton
        self.navigationController?.navigationBar.tintColor = Colors.mainBlue
        
        customView.titleTextField.addTarget(self, action:  #selector(textFieldChanged(_:)), for: .editingChanged)
        customView.memoTextField.addTarget(self, action:  #selector(textFieldChanged(_:)), for: .editingChanged)
        
        customView.registerTableView.delegate = self
        customView.registerTableView.dataSource = self
    }
    
    @objc func cancelButtonPressed() {
        self.dismiss(animated: true)
    }
    
    @objc func addButtonPressed() {
        let reminder = Reminder(memoTitle: textArr[0], memoDescription: textArr[1], date: list[0], hashtag: list[1], priority: list[2])
        try! realm.write {
            realm.add(reminder)
            transferData?()
            self.dismiss(animated: true)
        }
    }
    
    @objc private func textFieldChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        textArr[textField.tag] = text
        
        if textArr.contains("") {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
        
        print(textArr)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.identifier, for: indexPath) as? RegisterTableViewCell
        guard let cell else { return UITableViewCell() }
        guard let title = Names.registerTitle(rawValue: indexPath.row)?.name else { return UITableViewCell() }
        cell.titleLabel.text = title
        cell.valueLabel.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let register = Names.registerTitle(rawValue: indexPath.row) else { return }
        
        switch register {
        case .date:
            let vc = DateViewController(view: DateView())
            vc.transferData = { date in
                self.list[0] = date
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case .tag:
            let vc = TagViewController(view: TagView())
            vc.transferData = { tag in
                self.list[1] = tag
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case .priority:
            let vc = PriorityViewController(view: PriorityView())
            vc.transferData = { priority in
                self.list[2] = priority
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case .image:
            break
        }
    }
}
