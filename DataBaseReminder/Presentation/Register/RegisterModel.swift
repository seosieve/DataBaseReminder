//
//  RegisterModel.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/6/24.
//

import UIKit

protocol ReminderRegisterDelegate: AnyObject {
    func updateAddButton(_ state: Bool)
    func updateStringResult(_ stringResult: String, index: Int)
}

class RegisterModel {
    
    weak var delegate: ReminderRegisterDelegate?
    
    var textArr: (title: String, memo: String) = (String(), String()) {
        didSet {
            let state = !textArr.title.isEmpty && !textArr.memo.isEmpty
            delegate?.updateAddButton(state)
        }
    }
    
    var date: Date? {
        didSet {
            guard let date else { return }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy. MM. dd"
            delegate?.updateStringResult(formatter.string(from: date), index: 0)
        }
    }
    
    var hashTag: String? {
        didSet {
            delegate?.updateStringResult(hashTag ?? String(), index: 1)
        }
    }
    
    var priority: Int? {
        didSet {
            guard let priority, let priorityName = Names.priorityNames(rawValue: priority) else { return }
            delegate?.updateStringResult(String(describing: priorityName), index: 2)
        }
    }
    
    var image: UIImage? {
        didSet {
            delegate?.updateStringResult(image != nil ? "Image Selected": String(), index: 3)
        }
    }
}
