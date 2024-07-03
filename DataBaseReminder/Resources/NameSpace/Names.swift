//
//  Names.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import Foundation

enum Names {
    enum registerTitle: Int {
        case date
        case tag
        case priority
        case image
        
        var name: String {
            switch self {
            case .date:
                return "마감일"
            case .tag:
                return "태그"
            case .priority:
                return "우선 순위"
            case .image:
                return "이미지 추가"
            }
        }
    }
}
