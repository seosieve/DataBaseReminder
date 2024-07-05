//
//  BundleView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/5/24.
//

import UIKit
import SnapKit

class BundleView: BaseView {
    
    let calendarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "calendar.circle")
        button.tintColor = Colors.mainBlue
        button.style = .plain
        return button
    }()
    
    let filterButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "ellipsis.circle")
        button.tintColor = Colors.mainBlue
        button.style = .plain
        return button
    }()
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let screenWidth = UIScreen.main.bounds.width
        let spacing = layout.minimumLineSpacing + layout.sectionInset.left + layout.sectionInset.left
        layout.itemSize = CGSize(width: (screenWidth - spacing) / 2, height: 95)
        return layout
    }()
    
    lazy var bundleCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(BundleCollectionViewCell.self, forCellWithReuseIdentifier: BundleCollectionViewCell.identifier)
        return collectionView
    }()
    
    let addButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Colors.mainBlue
        config.imagePlacement = .leading
        ///Configure Image
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .heavy)
        config.image = UIImage(systemName: "plus.circle.fill", withConfiguration: imageConfig)
        config.imagePadding = 8
        ///Configure Title
        var titleAttr = AttributedString("새로운 할 일")
        titleAttr.font = .boldSystemFont(ofSize: 17)
        config.attributedTitle = titleAttr

        let button = UIButton(configuration: config)
        return button
    }()
    
    override func configureView() {
        self.backgroundColor = Colors.mainBlack
    }
    
    override func configureSubViews() {
        self.addSubview(bundleCollectionView)
        self.addSubview(addButton)
    }
    
    override func configureConstraints() {
        bundleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(addButton.snp.top)
        }
        
        addButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(6)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureNavigationController(_ vc: UIViewController) {
        vc.navigationItem.title = "전체"
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        vc.navigationItem.rightBarButtonItems = [filterButtonItem, calendarButtonItem]
    }
}

