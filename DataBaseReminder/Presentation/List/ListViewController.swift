//
//  ListViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit
import RealmSwift

final class ListViewController: BaseViewController<ListView> {
    
    let repository = ReminderRepository()
    
    var list: Results<Reminder>!
    
    override func configureView() {
        ///Configure Nav
        customView.configureNavigationController(self)
        ///TableView Delegate
        customView.listTableView.delegate = self
        customView.listTableView.dataSource = self
        ///Sort Menu Delegate
        customView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: Names.reloadBundle, object: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ListDetailViewController(view: ListDetailView())
        vc.reminder = list[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
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
        FileManagerRepository.removeImage(list[indexPath.row].key)
        repository.deleteObject(object: list[indexPath.row])
        customView.listTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func flagAction(indexPath: IndexPath) {
        repository.updateObject(object: list[indexPath.row], key: "flag")
        ///Delete Animation When Flag List
        if let title = self.navigationItem.title, title == Names.BundleNames.flag.title {
            UIView.animate(withDuration: 0.3, delay: 0.5) {
                self.customView.listTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func radioButtonTapped(in cell: ListTableViewCell) {
        guard let indexPath = customView.listTableView.indexPath(for: cell) else { return }
        repository.updateObject(object: list[indexPath.row], key: "complete")
        ///Delete Animation When Complete List
        if let title = self.navigationItem.title, title == Names.BundleNames.complete.title {
            customView.listTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: - ListSortDelegate
extension ListViewController: ListSortDelegate {
    func sortList(action: UIAction) {
        switch action.title {
        case "제목순":
            list = list.sorted(byKeyPath: "title")
        case "우선순위순":
            list = list.sorted(byKeyPath: "priority", ascending: false)
        case "최신순":
            list = list.sorted(byKeyPath: "dueDate")
        default:
            break
        }
        customView.listTableView.reloadData()
    }
}

