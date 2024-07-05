//
//  Names.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit

enum Names {
    enum registerNames: String, CaseIterable {
        case date = "마감일"
        case tag = "태그"
        case priority = "우선 순위"
        case image = "이미지 추가"
    }
    
    enum radioButtonNames {
        case selected
        case deselected
        
        var image: UIImage? {
            switch self {
            case .selected:
                return UIImage(systemName: "circle.inset.filled")
            case .deselected:
                return UIImage(systemName: "circle")
            }
        }
        
        mutating func toggle() {
            self = self == .selected ? .deselected : .selected
        }
    }
    
//    
//    "calender.badge.plus"
//    "calender"
//    "tray.fill"
//    "flag"
//    "checkmark"
}
