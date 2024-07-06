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
        
        let reminder = list[indexPath.row]
        cell.configureCell(reminder: reminder)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let flagImage = UIImage(systemName: "flag.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        let unflagImage = UIImage(systemName: "flag", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        
        let delete = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.deleteAction(indexPath: indexPath)
            success(true)
        }
       
        let flag = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.flagAction(indexPath: indexPath)
            success(true)
        }
        
        delete.backgroundColor = Colors.trashPink
        flag.backgroundColor = Colors.flagOrange
        
        delete.image = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        flag.image = list[indexPath.row].flag ? flagImage : unflagImage
        
        return UISwipeActionsConfiguration(actions: [delete, flag])
    }
    
    func deleteAction(indexPath: IndexPath) {
        repository.deleteObject(object: list[indexPath.row])
        customView.listTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func flagAction(indexPath: IndexPath) {
        repository.updateObject(object: list[indexPath.row])
    }
    
    func radioButtonTapped(in cell: ListTableViewCell) {
        guard let indexPath = customView.listTableView.indexPath(for: cell) else { return }
        print(indexPath)
    }
}

