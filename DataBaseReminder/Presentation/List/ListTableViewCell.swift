//
//  ListTableViewCell.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit
import SnapKit

protocol ListTableViewButtonDelegate: AnyObject {
    func radioButtonTapped(in cell: ListTableViewCell)
}

class ListTableViewCell: BaseTableViewCell {
    
    weak var delegate: ListTableViewButtonDelegate?
    
    private lazy var radioButton = {
        let button = UIButton()
        button.tintColor = Colors.descriptionBlack
        button.setImage(Names.radioButtonNames.deselected.image, for: .normal)
        button.setImage(Names.radioButtonNames.selected.image, for: .selected)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
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
        contentView.addSubview(radioButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(hashTagLabel)
    }

    override func configureConstraints() {
        radioButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(34)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(radioButton)
            make.leading.equalTo(radioButton.snp.trailing).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(titleLabel)
        }
        
        hashTagLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.leading.equalTo(descriptionLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let color = sender.isSelected ? Colors.descriptionBlack : Colors.contentBlue
        sender.tintColor = color
        sender.isSelected.toggle()
        delegate?.radioButtonTapped(in: self)
    }
}
