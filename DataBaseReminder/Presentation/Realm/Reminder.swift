//
//  Reminder.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import Foundation
import RealmSwift

class Reminder: Object {
    @Persisted(primaryKey: true) var key: ObjectId
    @Persisted(indexed: true) var title: String
    @Persisted var memo: String
    @Persisted var dueDate: Date?
    @Persisted var hashTag: String?
    @Persisted var priority: Int?
    @Persisted var flag: Bool
    @Persisted var complete: Bool
    
    convenience init(title: String, memo: String, dueDate: Date?, hashTag: String?, priority: Int?)  {
        self.init()
        self.title = title
        self.memo = memo
        self.dueDate = dueDate
        self.hashTag = hashTag
        self.priority = priority
        self.flag = false
        self.complete = false
    }
}
