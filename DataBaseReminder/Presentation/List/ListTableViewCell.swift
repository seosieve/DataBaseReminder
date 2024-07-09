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
    
    let priorityLabel = {
        let label = UILabel()
        label.text = "★★★"
        label.textColor = Colors.contentBlue
        label.font = .boldSystemFont(ofSize: 18)
        return label
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
        label.textColor = Colors.descriptionBlack
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let dueDateLabel = {
        let label = UILabel()
        label.text = "2024. 02. 20"
        label.textColor = Colors.contentBlack
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
    
    let listImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Colors.contentBlack
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    override func configureView() {
        selectionStyle = .none
        contentView.backgroundColor = Colors.mainBlack
    }

    override func configureSubViews() {
        contentView.addSubview(radioButton)
        contentView.addSubview(priorityLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dueDateLabel)
        contentView.addSubview(hashTagLabel)
        contentView.addSubview(listImageView)
    }

    override func configureConstraints() {
        radioButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(34)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(radioButton)
            make.leading.equalTo(radioButton.snp.trailing).offset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(radioButton)
            make.leading.equalTo(priorityLabel.snp.trailing).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(priorityLabel)
        }
        
        dueDateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.leading.equalTo(descriptionLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        hashTagLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.leading.equalTo(dueDateLabel.snp.trailing).offset(8)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        listImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(100)
            make.verticalEdges.equalToSuperview().inset(10)
            make.height.equalTo(listImageView.snp.width).multipliedBy(0.8)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let color = sender.isSelected ? Colors.descriptionBlack : Colors.contentBlue
        sender.tintColor = color
        sender.isSelected.toggle()
        delegate?.radioButtonTapped(in: self)
    }
    
    func configureCell(reminder: Reminder) {
        radioButton.tintColor = reminder.complete ? Colors.contentBlue : Colors.descriptionBlack
        radioButton.isSelected = reminder.complete
        
        if let priority = reminder.priority {
            priorityLabel.text = String(repeating: "★", count: priority + 1)
            titleLabel.snp.updateConstraints { make in
                make.leading.equalTo(priorityLabel.snp.trailing).offset(8)
            }
        } else {
            priorityLabel.text = String()
            titleLabel.snp.updateConstraints { make in
                make.leading.equalTo(priorityLabel.snp.trailing)
            }
        }
        
        titleLabel.text = reminder.title
        descriptionLabel.text = reminder.memo
        
        if let dueDate = reminder.dueDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy. MM. dd"
            dueDateLabel.text = formatter.string(from: dueDate)
            hashTagLabel.snp.updateConstraints { make in
                make.leading.equalTo(dueDateLabel.snp.trailing).offset(8)
            }
        } else {
            dueDateLabel.text = String()
            hashTagLabel.snp.updateConstraints { make in
                make.leading.equalTo(dueDateLabel.snp.trailing)
            }
        }
        
        if let hashTag = reminder.hashTag {
            hashTagLabel.text = "#" + hashTag
        } else {
            hashTagLabel.text = String()
        }
        
        if let image = FileManagerRepository.loadImage(reminder.key) {
            listImageView.isHidden = false
            listImageView.image = image
        } else {
            listImageView.isHidden = true
            listImageView.image = UIImage()
        }
    }
}
