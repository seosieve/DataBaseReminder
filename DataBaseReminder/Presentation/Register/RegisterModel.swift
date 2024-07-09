//
//  RegisterModel.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/6/24.
//

import UIKit

class RegisterModel {
    
    let repository = ReminderRepository()
    
    let inputTitleAction: Observable<String> = Observable("")
    let inputMenoAction: Observable<String> = Observable("")
    let inputAddAction: Observable<Void?> = Observable(nil)
    
    let inputDateAction: Observable<Date?> = Observable(nil)
    let inputHashTagAction: Observable<String?> = Observable(nil)
    let inputPriorityAction: Observable<Int?> = Observable(nil)
    let inputImageAction: Observable<UIImage?> = Observable(nil)
    
    let outputValid: Observable<Bool> = Observable(false)
    let outputOptionals: Observable<[String?]> = Observable([nil, nil, nil, nil])
    
    init() {
        inputTitleAction.bind { _ in
            self.updateAddButton()
        }
        
        inputMenoAction.bind { _ in
            self.updateAddButton()
        }
        
        inputAddAction.bind { value in
            guard let value else { return }
            self.addReminderData()
        }
        
        inputDateAction.bind { value in
            guard let value else { return }
            self.updateDateResult(date: value)
        }
        
        inputHashTagAction.bind { value in
            guard let value else { return }
            self.updateHashTagResult(hashTag: value)
        }
        
        inputPriorityAction.bind { value in
            guard let value else { return }
            self.updatePriorityResult(priority: value)
        }
        
        inputImageAction.bind { value in
            guard let value else { return }
            self.updateImageResult(image: value)
        }
    }
    
    private func updateAddButton() {
        let (title, memo) = (inputTitleAction.value, inputMenoAction.value)
        outputValid.value = !title.isEmpty && !memo.isEmpty
    }
    
    private func addReminderData() {
        let title = inputTitleAction.value
        let memo = inputMenoAction.value
        let dueDate = inputDateAction.value
        let hashTag = inputHashTagAction.value
        let priority = inputPriorityAction.value
        
        let reminder = Reminder(title: title, memo: memo, dueDate: dueDate, hashTag: hashTag, priority: priority)
        repository.addObject(object: reminder)
        
        guard let image = inputImageAction.value else { return }
        FileManagerRepository.addImage(image, reminder.key)
    }
    
    private func updateDateResult(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        outputOptionals.value[0] = formatter.string(from: date)
    }
    
    private func updateHashTagResult(hashTag: String) {
        outputOptionals.value[1] = hashTag
    }
    
    private func updatePriorityResult(priority: Int) {
        guard let name = Names.priorityNames(rawValue: priority) else { return }
        outputOptionals.value[2] = String(describing: name)
    }
    
    private func updateImageResult(image: UIImage) {
        outputOptionals.value[3] = "Image Selected"
    }
}
