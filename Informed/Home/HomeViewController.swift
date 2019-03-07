//
//  HomeViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class HomeViewController: BasicViewController {
    
    private lazy var tableView: UITableView = makeTableView()
    lazy var refreshController: UIRefreshControl = makeRefreshController()
    private let handler = HomeTableViewHandler()
    
    override func setupSubviews() {
        view.addSubview(tableView)
        view.embed(tableView)
    }
    
    override func setupLayoutConstraints() {
    }

    private func makeTableView() -> UITableView {
        let tableView = UITableView.forAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshController
        tableView.backgroundColor = UIColor.Informed.reallyDark
        HomeTableViewHandler.configure(tableView)
        return tableView
    }
    
    private func makeRefreshController() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = .white
        return refreshControl
    }
    
    @objc private func refresh(_ refreshControl: UIRefreshControl) {
        Election.getElections { (elections) in
            ElectionState.core.fire(.fetchedAll(elections))
            DispatchQueue.main.async {
                refreshControl.endRefreshing()
            }
        }
    }
}

// MARK: -
// MARK: lifecycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Informed.reallyDark
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        handler.buildRows()
        
        ElectionState.core.addSubscriber(subscriber: self, update: HomeViewController.update)
        Election.getElections { (elections) in
            ElectionState.core.fire(.fetchedAll(elections))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let sideSheetButton = UIBarButtonItem(image: UIImage(named: "Menu")!, style: .done, target: self, action: #selector(openSideSheet))
//        navigationItem.leftBarButtonItem = sideSheetButton
        
        navigationItem.title = "Informed"
    }
    
    @objc private func openSideSheet() {
        let vc = SideSheetHolderNavigationController()
        present(vc, animated: true, completion: nil)
    }
}

// MARK: -
// MARK: tableview
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return handler.sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handler.didSelectRow(at: indexPath) { vc in
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = handler.sections[section]
        return section.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = handler.row(for: indexPath)
        return row.height()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return handler.cell(for: indexPath, in: tableView)
    }
}

// MARK: -
// MARK: subscriber
extension HomeViewController: Subscriber {
    func update(with state: ElectionState) {
        handler.buildRows()
        tableView.reloadData()
    }
}
