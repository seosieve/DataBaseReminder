//
//  Colors.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit

enum Colors {
    static let mainBlue = UIColor("#0FB2F8")
    static let contentBlue = UIColor("#2D9ABA")
    
    static let mainBlack = UIColor("#0E0E0E")
    static let subBlack = UIColor("#1E1E1E")
    static let contentBlack = UIColor("#2C2C2C")
    static let descriptionBlack = UIColor("#707070")
}

//MARK: - UIColor with Hex
extension UIColor {
    convenience init(_ hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a,r,g,b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a,r,g,b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a,r,g,b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a,r,g,b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
