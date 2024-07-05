//
//  ListView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit
import SnapKit

class ListView: BaseView {
    
    let filterButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "ellipsis.circle")
        button.tintColor = Colors.contentBlue
        button.style = .plain
        return button
    }()
    
    let addButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus.circle")
        button.tintColor = Colors.contentBlue
        button.style = .plain
        return button
    }()
    
    let listTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = Colors.contentBlack
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        return tableView
    }()
    
    override func configureView() {
        self.backgroundColor = Colors.mainBlack
    }
    
    override func configureSubViews() {
        self.addSubview(listTableView)
    }
    
    override func configureConstraints() {
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func configureNavigationController(_ vc: UIViewController) {
        vc.navigationItem.title = "오늘"
        vc.navigationItem.rightBarButtonItem = filterButtonItem
        vc.navigationController?.navigationBar.tintColor = Colors.contentBlue
    }
}
