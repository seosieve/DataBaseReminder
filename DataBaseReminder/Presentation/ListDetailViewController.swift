//
//  ListDetailViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/9/24.
//

import UIKit
import RealmSwift

final class ListDetailViewController: BaseViewController<ListDetailView> {
    
    var reminder: Reminder!
    
    override func configureView() {
        ///Configure Nav
        customView.configureNavigationController(self, title: reminder.title)
        customView.configureView(reminder)
    }
    
}

