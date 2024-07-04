//
//  ListViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit
import RealmSwift

final class ListViewController: BaseViewController<ListView> {
    
    let list: Results<Reminder>!
    var realm = try! Realm()
    
    override init(view: ListView) {
        self.list = realm.objects(Reminder.self).sorted(byKeyPath: "date")
        super.init(view: view)
    }
    
    override func configureView() {
        ///Configure Nav
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addButtonPressed))
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(filterButtonPressed))
        navigationItem.rightBarButtonItems = [addButton, filterButton]
        self.navigationController?.navigationBar.tintColor = Colors.mainBlue
        ///TableView Delegate
        customView.listTableView.delegate = self
        customView.listTableView.dataSource = self
    }
    
    @objc func addButtonPressed() {
        let vc = RegisterViewController(view: RegisterView())
        vc.transferData = {
            self.customView.listTableView.reloadData()
        }
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationAppearance(color: Colors.subBlack)
        self.present(nav, animated: true)
    }
    
    @objc func filterButtonPressed() {
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell
        guard let cell else { return UITableViewCell() }
        let data = list[indexPath.row]
        
        cell.titleLabel.text = data.memoTitle
        cell.descriptionLabel.text = data.memoDescription
        cell.hashTagLabel.text = data.hashtag
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let remove = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.deleteAction(indexPath: indexPath)
            success(true)
        }
        remove.backgroundColor = .systemPink.withAlphaComponent(0.6)
        remove.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [remove])
    }
    
    func deleteAction(indexPath: IndexPath) {
        try! realm.write {
            realm.delete(list[indexPath.row])
        }
        
        customView.listTableView.deleteRows(at: [indexPath], with: .fade)
    }
}

