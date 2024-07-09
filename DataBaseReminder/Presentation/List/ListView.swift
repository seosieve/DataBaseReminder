//
//  ListView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit
import SnapKit

protocol ListSortDelegate: AnyObject {
    func sortList(sortName: Names.SortNames)
}

class ListView: BaseView {
    
    weak var delegate: ListSortDelegate?
    
    let sortArr = Names.SortNames.allCases
    
    private lazy var actions = [dateOrder, titleOrder, priorityOrder]
    
    private lazy var dateOrder = UIAction(title: sortArr[0].title, state: .on, handler: updateActionStates)
                                  
    private lazy var titleOrder = UIAction(title: sortArr[1].title, state: .off, handler: updateActionStates)
    
    private lazy var priorityOrder = UIAction(title: sortArr[2].title, state: .off, handler: updateActionStates)
    
    private lazy var updateActionStates: (UIAction) -> Void = { action in
        guard let index = self.sortArr.firstIndex(where: { $0.title == action.title }) else { return }
        
        let actions = self.actions
        actions.forEach { $0.state = ($0 == action) ? .on : .off }
        self.filterButtonItem.menu = UIMenu(options: .displayInline, children: actions)
        
        let sortName = self.sortArr[index]
        self.delegate?.sortList(sortName: sortName)
    }
    
    lazy var filterButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "ellipsis.circle")
        button.tintColor = Colors.mainBlue
        button.style = .plain
        button.menu = UIMenu(options: .displayInline, children: [dateOrder, titleOrder, priorityOrder])
        return button
    }()

    let listTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = Colors.contentBlack
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
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
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.navigationItem.rightBarButtonItem = filterButtonItem
        vc.navigationController?.navigationBar.tintColor = Colors.mainBlue
    }
}
