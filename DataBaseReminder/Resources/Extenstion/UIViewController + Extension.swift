//
//  UIViewController + Extension.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/5/24.
//

import UIKit

extension UIViewController {
    func removeBackButtonTitle() {
        let backBarButtonItem = UIBarButtonItem(title: "")
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

