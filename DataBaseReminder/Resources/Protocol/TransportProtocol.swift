//
//  TransportProtocol.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/6/24.
//

import UIKit

//Delegate Pattern For Data Transporting
protocol DataTransportDelegate: AnyObject {
    
    func transportDate(date: Date?)
    
    func transportHashTag(hashTag: String?)
    
    func transportPriority(priority: Int?)
    
    func transportImage(image: UIImage?)
}

//Make Subviews to Protocol Type
protocol SubViewType: AnyObject {
    var delegate: DataTransportDelegate? { get set }
}
