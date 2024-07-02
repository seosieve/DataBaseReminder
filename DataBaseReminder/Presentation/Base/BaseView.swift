//
//  BaseView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubViews()
        configureConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() { }
    
    func configureSubViews() { }
    
    func configureConstraints() { }
}
