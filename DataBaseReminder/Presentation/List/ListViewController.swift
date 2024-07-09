//
//  ListViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit

final class ListViewController: BaseViewController<ListView> {
    
    let model: ListModel
    
    init(view: ListView, model: ListModel) {
        self.model = model
        super.init(view: view)
    }
    
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
        return model.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell
        guard let cell else { return UITableViewCell() }
        
        let reminder = model.list[indexPath.row]
        cell.configureCell(reminder: reminder)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ListDetailViewController(view: ListDetailView())
        vc.reminder = model.list[indexPath.row]
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
        flag.image = model.list[indexPath.row].flag ? flagImage : unflagImage
        
        return UISwipeActionsConfiguration(actions: [delete, flag])
    }
    
    func deleteAction(indexPath: IndexPath) {
        model.inputDeleteAction.value = indexPath
        customView.listTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func flagAction(indexPath: IndexPath) {
        model.inputFlagAction.value = indexPath
        ///Delete Animation When Flag List
        if let title = self.navigationItem.title, title == Names.BundleNames.flag.title {
            UIView.animate(withDuration: 0.3, delay: 0.5) {
                self.customView.listTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func radioButtonTapped(in cell: ListTableViewCell) {
        guard let indexPath = customView.listTableView.indexPath(for: cell) else { return }
        model.inputRadioAction.value = indexPath
        ///Delete Animation When Complete List
        if let title = self.navigationItem.title, title == Names.BundleNames.complete.title {
            customView.listTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: - ListSortDelegate
extension ListViewController: ListSortDelegate {
    func sortList(sortName: Names.SortNames) {
        model.inputSortAction.value = sortName
        customView.listTableView.reloadData()
    }
}

