//
//  ListModel.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/9/24.
//

import UIKit
import RealmSwift

class ListModel {
    let repository = ReminderRepository()
    
    var list: Results<Reminder>
    
    let inputDeleteAction: Observable<IndexPath?> = Observable(nil)
    let inputFlagAction: Observable<IndexPath?> = Observable(nil)
    let inputRadioAction: Observable<IndexPath?> = Observable(nil)
    let inputSortAction: Observable<Names.SortNames?> = Observable(nil)
    
    init(list: Results<Reminder>) {
        self.list = list
        
        inputDeleteAction.bind { indexPath in
            guard let indexPath else { return }
            self.deleteObjectAndImage(indexPath: indexPath)
        }
        
        inputFlagAction.bind { indexPath in
            guard let indexPath else { return }
            self.flagObject(indexPath: indexPath)
        }
        
        inputRadioAction.bind { indexPath in
            guard let indexPath else { return }
            self.completeObject(indexPath: indexPath)
        }
        
        inputSortAction.bind { sortName in
            guard let sortName else { return }
            self.sortObject(sortName: sortName)
        }
    }
    
    private func deleteObjectAndImage(indexPath: IndexPath) {
        FileManagerRepository.removeImage(list[indexPath.row].key)
        repository.deleteObject(object: list[indexPath.row])
    }
    
    private func flagObject(indexPath: IndexPath) {
        repository.updateObject(object: list[indexPath.row], key: "flag")
    }
    
    private func completeObject(indexPath: IndexPath) {
        repository.updateObject(object: list[indexPath.row], key: "complete")
    }
    
    private func sortObject(sortName: Names.SortNames) {
        switch sortName {
        case .date:
            list = list.sorted(byKeyPath: "dueDate")
        case .title:
            list = list.sorted(byKeyPath: "title")
        case .priority:
            list = list.sorted(byKeyPath: "priority", ascending: false)
        }
    }
}
