//
//  UINavigationController + Extension.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit

extension UINavigationController {
    func setNavigationAppearance(backgroundColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = backgroundColor
        appearance.largeTitleTextAttributes = [.foregroundColor: Colors.contentBlack]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
