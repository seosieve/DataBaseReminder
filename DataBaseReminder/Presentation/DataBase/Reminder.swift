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
    @Persisted(indexed: true) var memoTitle: String
    @Persisted var memoDescription: String?
    @Persisted var date: String?
    @Persisted var hashtag: String?
    @Persisted var priority: String?
    
    convenience init(memoTitle: String, memoDescription: String, date: String?, hashtag: String?, priority: String?)  {
        self.init()
        self.memoTitle = memoTitle
        self.memoDescription = memoDescription
        self.date = date
        self.hashtag = hashtag
        self.priority = priority
    }
}
