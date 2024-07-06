//
//  BundleCollectionViewCell.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/5/24.
//

import UIKit

class BundleCollectionViewCell: BaseCollectionViewCell {
    
    let iconContainerView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = Colors.contentBlue
        return view
    }()
    
    let iconImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "오늘"
        label.textColor = Colors.descriptionBlack
        label.font = .systemFont(ofSize: 16, weight: .semibold)
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
        
        contentView.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
    }

    override func configureConstraints() {
        iconContainerView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.size.equalTo(36)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(14)
        }

        countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(15)
        }
    }
    
    func configureCell(bundle: Names.BundleNames, count: Int) {
        iconContainerView.backgroundColor = bundle.color
        iconImageView.image = bundle.image
        titleLabel.text = bundle.title
        countLabel.text = String(count)
    }
}
