//
//  NSObjectProtocol + Extenstion.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit

extension NSObjectProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
