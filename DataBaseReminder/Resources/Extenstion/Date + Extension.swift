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
    //Return Current Page Of FSCalendat
    static func currentCalendar(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월"
        let date = dateFormatter.string(from: date)
        return date
    }
    //Return Month And Day
    static func selectedDay(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "M월 d일"
        let date = dateFormatter.string(from: date)
        return date
    }
}

