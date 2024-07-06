//
//  Date + Extension.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/6/24.
//

import Foundation

extension Date {
    //Return Date Without Time
    static func removeTime(date: Date = Date()) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)!
    }
}
