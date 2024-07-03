//
//  UIDatePicker + Extension.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit

extension UIDatePicker {
    var textColor: UIColor? {
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
        get {
            return value(forKeyPath: "textColor") as? UIColor
        }
    }
}
