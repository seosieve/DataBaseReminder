//
//  ListView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit
import SnapKit

class ListView: BaseView {
    
    let listTableView = {
        let tableView = UITableView()
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        return tableView
    }()
    
    override func configureView() {
        self.backgroundColor = .black
    }
    
    override func configureSubViews() {
        self.addSubview(listTableView)
    }
    
    override func configureConstraints() {
        listTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
