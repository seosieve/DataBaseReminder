//
//  BundleCollectionViewCell.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/5/24.
//

import UIKit

class BundleCollectionViewCell: BaseCollectionViewCell {
    
    let iconImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = Colors.contentBlue
        return imageView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "오늘"
        label.textColor = Colors.descriptionBlack
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    let countLabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    override func configureView() {
        contentView.backgroundColor = Colors.contentBlack
        contentView.layer.cornerRadius = 10
    }

    override func configureSubViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
    }

    override func configureConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(15)
        }

        countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(15)
        }
    }
}
