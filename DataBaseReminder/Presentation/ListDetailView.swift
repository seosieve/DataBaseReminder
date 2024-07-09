//
//  ListDetailView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/9/24.
//

import UIKit
import SnapKit

class ListDetailView: BaseView {
    
    let priorityLabel = {
        let label = UILabel()
        label.text = "★★★"
        label.textColor = Colors.contentBlue
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    let memoLabel = {
        let label = UILabel()
        label.textColor = Colors.descriptionBlack
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    let dueDateLabel = {
        let label = UILabel()
        label.text = "2024. 02. 20"
        label.textColor = Colors.contentBlack
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let hashTagLabel = {
        let label = UILabel()
        label.text = "#공부"
        label.textColor = Colors.contentBlue
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let imageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Colors.contentBlack
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override func configureView() {
        self.backgroundColor = Colors.mainBlack
    }
    
    override func configureSubViews() {
        self.addSubview(priorityLabel)
        self.addSubview(memoLabel)
        self.addSubview(dueDateLabel)
        self.addSubview(hashTagLabel)
        self.addSubview(imageView)
    }
    
    override func configureConstraints() {
        priorityLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(16)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(priorityLabel.snp.trailing).offset(12)
        }
        
        dueDateLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(8)
            make.leading.equalTo(priorityLabel)
        }
        
        hashTagLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(8)
            make.leading.equalTo(dueDateLabel.snp.trailing).offset(16)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(dueDateLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(250)
        }
    }
    
    func configureNavigationController(_ vc: UIViewController, title: String) {
        vc.navigationItem.title = title
    }
    
    func configureView(_ reminder: Reminder) {
        if let priority = reminder.priority {
            priorityLabel.text = String(repeating: "★", count: priority + 1)
            memoLabel.snp.updateConstraints { make in
                make.leading.equalTo(priorityLabel.snp.trailing).offset(16)
            }
        } else {
            priorityLabel.text = String()
            memoLabel.snp.updateConstraints { make in
                make.leading.equalTo(priorityLabel.snp.trailing)
            }
        }
        memoLabel.text = reminder.memo
        
        if let dueDate = reminder.dueDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy. MM. dd"
            dueDateLabel.text = formatter.string(from: dueDate)
            hashTagLabel.snp.updateConstraints { make in
                make.leading.equalTo(dueDateLabel.snp.trailing).offset(16)
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
            imageView.isHidden = false
            imageView.image = image
        } else {
            imageView.isHidden = true
            imageView.image = UIImage()
        }
    }
}

