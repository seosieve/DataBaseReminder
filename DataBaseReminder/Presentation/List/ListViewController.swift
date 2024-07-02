//
//  ListViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/2/24.
//

import UIKit

class ListViewController: BaseViewController {
    
    var customView: ListView!
    
    init(view: ListView) {
        super.init()
        self.customView = view
    }
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.listTableView.delegate = self
        customView.listTableView.dataSource = self
        customView.listTableView.rowHeight = 100
        print("실행안됨")
    }
    
    override func configureView() {

    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell
        guard let cell else { return UITableViewCell() }
        return cell
    }
}

