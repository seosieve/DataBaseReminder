//
//  Names.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit
import RealmSwift

enum Names {
    enum registerNames: String, CaseIterable {
        case date = "마감일"
        case tag = "태그"
        case priority = "우선 순위"
        case image = "이미지 추가"
        
        var viewController: UIViewController {
            switch self {
            case .date:
                return DateViewController(view: DateView())
            case .tag:
                return HashTagViewController(view: HashTagView())
            case .priority:
                return PriorityViewController(view: PriorityView())
            case .image:
                return ImageViewController(view: ImageView())
            }
        }
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
    
    enum BundleNames: CaseIterable {
        case today
        case schedule
        case total
        case flag
        case complete
        
        var image: UIImage? {
            switch self {
            case .today:
                return UIImage(systemName: "calendar.badge.checkmark")
            case .schedule:
                return UIImage(systemName: "calendar")
            case .total:
                return UIImage(systemName: "tray.fill")
            case .flag:
                return UIImage(systemName: "flag.fill")
            case .complete:
                let imageConfig = UIImage.SymbolConfiguration(weight: .semibold)
                return UIImage(systemName: "checkmark", withConfiguration: imageConfig)
            }
        }
        
        var title: String {
            switch self {
            case .today:
                return "오늘"
            case .schedule:
                return "예정"
            case .total:
                return "전체"
            case .flag:
                return "깃발 표시"
            case .complete:
                return "완료됨"
            }
        }
        
        var color: UIColor? {
            switch self {
            case .today:
                return UIColor("#026E81")
            case .schedule:
                return UIColor("#00ABBD")
            case .total:
                return UIColor("#0099DD")
            case .flag:
                return UIColor("#FF9933")
            case .complete:
                return UIColor("#8DCAF2")
            }
        }
    }
    
    enum priorityNames: Int, CaseIterable {
        case FIRST
        case SECOND
        case THIRD
    }
}
