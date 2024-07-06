//
//  BundleViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/5/24.
//

import UIKit

final class BundleViewController: BaseViewController<BundleView> {
    
    let repository = ReminderRepository()
    
    override func configureView() {
        ///Configure Nav
        customView.filterButtonItem.target = self
        customView.filterButtonItem.action = #selector(filterButtonPressed)
        customView.configureNavigationController(self)
        ///TableView Delegate
        customView.bundleCollectionView.delegate = self
        customView.bundleCollectionView.dataSource = self
        ///AddButton
        customView.addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    @objc func filterButtonPressed() {
        
    }
    
    @objc func addButtonPressed() {
        let vc = RegisterViewController(view: RegisterView(), model: RegisterModel())
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationAppearance(backgroundColor: Colors.subBlack)
        self.present(nav, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension BundleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BundleCollectionViewCell.identifier, for: indexPath) as? BundleCollectionViewCell
        guard let cell else { return UICollectionViewCell() }
        
        let bundle = Names.BundleNames.allCases[indexPath.row]
        let count = repository.filterObject(bundle: bundle).count
        cell.configureCell(bundle: bundle, count: count)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bundle = Names.BundleNames.allCases[indexPath.row]
        let vc = ListViewController(view: ListView())
        vc.navigationItem.title = bundle.title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - ObjectAddDelegate
extension BundleViewController: ObjectAddDelegate {
    func objectAdded() {
        customView.bundleCollectionView.reloadData()
    }
}
