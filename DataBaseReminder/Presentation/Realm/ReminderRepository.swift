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
    lazy var fileURL = realm.configuration.fileURL
    
    lazy var allObjects = realm.objects(Reminder.self)
    
    func filterObject(bundle: Names.BundleNames) -> Results<Reminder> {
        switch bundle {
        case .today:
            return realm.objects(Reminder.self).where{ $0.dueDate != nil && $0.dueDate == Date.removeTime() }
        case .schedule:
            return realm.objects(Reminder.self).where{ $0.dueDate != nil && $0.dueDate > Date() }
        case .total:
            return realm.objects(Reminder.self)
        case .flag:
            return realm.objects(Reminder.self).where{ $0.flag == true }
        case .complete:
            return realm.objects(Reminder.self).where{ $0.complete == true }
        }
    }
    
    func addObject(object: Reminder) {
        do {
            try realm.write {
                realm.add(object)
                print("Add Completed")
            }
        } catch {
            print("Error Add Realm Object: \(error.localizedDescription)")
        }
    }
    
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
