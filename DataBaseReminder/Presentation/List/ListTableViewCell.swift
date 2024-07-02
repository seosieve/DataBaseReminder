//
//  ListTableViewCell.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit
import SnapKit

class ListTableViewCell: BaseTableViewCell {
    
    let titleLabel = {
        let label = UILabel()
        label.text = "안녕안녕"
        return label
    }()

    override func configureView() {
        
    }

    override func configureSubViews() {
        contentView.addSubview(titleLabel)
    }

    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
    }
}
