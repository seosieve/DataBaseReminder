//
//  RegisterTableViewCell.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/3/24.
//

import UIKit
import SnapKit

class RegisterTableViewCell: BaseTableViewCell {
    
    private lazy var containerView = {
        let view = UIView()
        view.backgroundColor = Colors.contentBlack
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "안녕안녕"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let valueLabel = {
        let label = UILabel()
        label.text = "안녕안녕"
        label.textColor = Colors.descriptionBlack
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let chevronImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.tintColor = Colors.descriptionBlack
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func configureView() {
        selectionStyle = .none
        contentView.backgroundColor = Colors.subBlack
    }

    override func configureSubViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)
        containerView.addSubview(chevronImageView)
    }

    override func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(20)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-14)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(10)
        }
    }
}
