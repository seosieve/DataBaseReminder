//
//  ImageView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/6/24.
//

import UIKit
import SnapKit
import PhotosUI

class ImageView: BaseView {
    
    let configuration = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.screenshots, .images])
        return configuration
    }()
    
    lazy var picker = PHPickerViewController(configuration: configuration)
    
    let imageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Colors.contentBlack
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let addImageButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 80, weight: .medium)
        button.setImage(UIImage(systemName: "plus", withConfiguration: imageConfig), for: .normal)
        button.tintColor = Colors.descriptionBlack.withAlphaComponent(0.2)
        return button
    }()
    
    override func configureView() {
        self.backgroundColor = Colors.subBlack
    }
    
    override func configureSubViews() {
        self.addSubview(imageView)
        imageView.addSubview(addImageButton)
    }
    
    override func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(350)
        }
        
        addImageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.navigationItem.title = "이미지 추가"
    }
}

