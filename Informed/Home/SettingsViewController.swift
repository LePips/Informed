//
//  SettingsViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 1/24/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import SharedPips

class SettingsViewController: BasicViewController {
    
    private lazy var tableView = makeTableView()
    
    override func setupSubviews() {
        view.embed(tableView)
    }
    
    override func setupLayoutConstraints() {
        
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView.forAutoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }
    
}

extension SettingsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
