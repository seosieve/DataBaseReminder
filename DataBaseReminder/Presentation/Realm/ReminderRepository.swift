//
//  ReminderRepository.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/4/24.
//

import Foundation
import RealmSwift

final class ReminderRepository {
    
    private let realm = RealmManager.shared.realm
    
    ///Functions
    lazy var allObjects = realm.objects(Reminder.self)
    
    func deleteObject(object: Reminder) {
        do {
            try realm.write {
                realm.delete(object)
                print("Delete Completed")
            }
        } catch {
            print("Error Delete Realm Object: \(error.localizedDescription)")
        }
    }
}
