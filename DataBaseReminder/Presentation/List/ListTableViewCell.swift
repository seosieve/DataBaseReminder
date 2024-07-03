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
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.text = "예쁜 키캡 알아보기"
        label.textColor = .systemGray3
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let hashTagLabel = {
        let label = UILabel()
        label.text = "#공부"
        label.textColor = Colors.contentBlue
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    override func configureView() {
        selectionStyle = .none
        contentView.backgroundColor = Colors.mainBlack
    }

    override func configureSubViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(hashTagLabel)
    }

    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(20)
        }
        
        hashTagLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
