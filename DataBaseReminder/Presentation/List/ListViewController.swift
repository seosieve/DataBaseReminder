//
//  ListViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit

final class ListViewController: BaseViewController<ListView> {
    
    let repository = ReminderRepository()
    
    lazy var list = repository.allObjects
    
    override init(view: ListView) {
        super.init(view: view)
    }
    
    override func configureView() {
        ///Configure Nav
        customView.filterButtonItem.target = self
        customView.filterButtonItem.action = #selector(filterButtonPressed)
        customView.configureNavigationController(self)
        ///TableView Delegate
        customView.listTableView.delegate = self
        customView.listTableView.dataSource = self
    }
    
    @objc func filterButtonPressed() {
        self.navigationController?.viewControllers.forEach { vc in
            if let aa = vc as? BaseViewController {
                
            }
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource, ListTableViewButtonDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell
        guard let cell else { return UITableViewCell() }
        let data = list[indexPath.row]
        
        cell.delegate = self
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
        repository.deleteObject(object: list[indexPath.row])
        customView.listTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func radioButtonTapped(in cell: ListTableViewCell) {
        guard let indexPath = customView.listTableView.indexPath(for: cell) else { return }
        print(indexPath)
    }
}

