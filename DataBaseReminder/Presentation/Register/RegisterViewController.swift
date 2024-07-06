//
//  RegisterViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit
import RealmSwift

class RegisterViewController: BaseViewController<RegisterView> {
    
    let repository = ReminderRepository()
    let model: RegisterModel
    
    var stringResultArr = Array(repeating: String(), count: 4)
    
    init(view: RegisterView, model: RegisterModel) {
        self.model = model
        super.init(view: view)
    }
    
    override func configureView() {
        ///Configure Nav
        customView.cancelButtonItem.target = self
        customView.cancelButtonItem.action = #selector(cancelButtonPressed)
        customView.addButtonItem.target = self
        customView.addButtonItem.action = #selector(addButtonPressed)
        customView.configureNavigationController(self)
        ///TextField & TextView
        customView.titleTextField.delegate = self
        customView.memoTextView.delegate = self
        ///TableView Delegate
        customView.registerTableView.delegate = self
        customView.registerTableView.dataSource = self
        ///Model
        model.delegate = self
    }
    
    @objc func cancelButtonPressed() {
        self.dismiss(animated: true)
    }
    
    @objc func addButtonPressed() {
//        let reminder = Reminder(memoTitle: textArr[0], memoDescription: textArr[1], date: list[0], hashtag: list[1], priority: list[2])
//        try! realm.write {
//            realm.add(reminder)
//            transferData?()
//            self.dismiss(animated: true)
//        }
    }    
}

//MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text, let range = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        model.textArr.title = updatedText
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customView.memoTextView.becomeFirstResponder()
        return true
    }
}

//MARK: - UITextViewDelegate
extension RegisterViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Colors.descriptionBlack {
            textView.text = nil
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메모"
            textView.textColor = Colors.descriptionBlack
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text != "\n" else { textView.resignFirstResponder(); return false }
        guard let currentText = textView.text, let range = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: range, with: text)
        model.textArr.memo = updatedText
        return true
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringResultArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.identifier, for: indexPath) as? RegisterTableViewCell
        guard let cell else { return UITableViewCell() }
        let title = Names.registerNames.allCases[indexPath.row].rawValue
        cell.titleLabel.text = title
        cell.valueLabel.text = stringResultArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let register = Names.registerNames.allCases[indexPath.row]
        let vc = register.viewController
        guard let subViewController = vc as? SubViewType else { return }
        subViewController.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - TextArrayDelegate
extension RegisterViewController: ReminderRegisterDelegate {
    func updateAddButton(_ state: Bool) {
        customView.addButtonItem.isEnabled = state
    }
    
    func updateStringResult(_ stringResult: String, index: Int) {
        stringResultArr[index] = stringResult
        customView.registerTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

//MARK: - DataTransportDelegate
extension RegisterViewController: DataTransportDelegate {
    func transportDate(date: Date?) {
        model.date = date
    }
    
    func transportHashTag(hashTag: String?) {
        model.hashTag = hashTag
    }
    
    func transportPriority(priority: Int?) {
        model.priority = priority
    }
    
    func transportImage(image: UIImage?) {
        model.image = image
    }
}
