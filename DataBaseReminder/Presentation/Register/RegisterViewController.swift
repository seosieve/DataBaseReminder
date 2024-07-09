//
//  RegisterViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit
import RealmSwift

class RegisterViewController: BaseViewController<RegisterView> {
    
    let model: RegisterModel
    
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
        bindData()
    }
    
    @objc func cancelButtonPressed() {
        self.dismiss(animated: true)
    }
    
    @objc func addButtonPressed() {
        model.inputAddAction.value = ()
        NotificationCenter.default.post(name: Names.reloadBundle, object: nil)
        self.dismiss(animated: true)
    }
    
    func bindData() {
        model.outputValid.bind { state in
            self.customView.addButtonItem.isEnabled = state
        }
        
        model.outputOptionals.bind { optionals in
            print(optionals)
            self.customView.registerTableView.reloadData()
        }
    }
}

//MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text, let range = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        model.inputTitleAction.value = updatedText
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
        model.inputMenoAction.value = updatedText
        return true
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.outputOptionals.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.identifier, for: indexPath) as? RegisterTableViewCell
        guard let cell else { return UITableViewCell() }
        let title = Names.registerNames.allCases[indexPath.row].rawValue
        cell.titleLabel.text = title
        cell.valueLabel.text = model.outputOptionals.value[indexPath.row]
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

//MARK: - DataTransportDelegate
extension RegisterViewController: DataTransportDelegate {
    func transportDate(date: Date?) {
        model.inputDateAction.value = date
    }
    
    func transportHashTag(hashTag: String?) {
        model.inputHashTagAction.value = hashTag
    }
    
    func transportPriority(priority: Int?) {
        model.inputPriorityAction.value = priority
    }
    
    func transportImage(image: UIImage?) {
        model.inputImageAction.value = image
    }
}
