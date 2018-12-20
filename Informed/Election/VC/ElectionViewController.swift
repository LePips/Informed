//
//  ElectionViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips
import FirebaseAuth

class ElectionViewController: UIViewController {
    
    var election: Election!
    var rows = [ElectionRow]()
    
    private lazy var statusBarUnderlay: UIView = self._statusBarUnderlay()
    private func _statusBarUnderlay() -> UIView {
        let underlay = UIView.forAutoLayout()
        
        view.addSubview(underlay)
        NSLayoutConstraint.activate([
            underlay.topAnchor ⩵ view.topAnchor,
            underlay.leftAnchor ⩵ view.leftAnchor,
            underlay.rightAnchor ⩵ view.rightAnchor,
            underlay.heightAnchor ⩵ 20
            ])
        
        underlay.backgroundColor = .white
        
        return underlay
    }
    
    private lazy var tableView: UITableView = self._tableView()
    private func _tableView() -> UITableView {
        let tableView = UITableView.forAutoLayout()
        
        view.embed(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        ElectionRow.configure(tableView)
        tableView.separatorStyle = .none
        
        return tableView
    }
    
    init(with election: Election) {
        self.election = election
        super.init(nibName: nil, bundle: nil)
        navigationItem.largeTitleDisplayMode = .never
        title = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = tableView
        _ = statusBarUnderlay
        
        self.rows = ElectionRow.buildRows(election: election)
    }
}

extension ElectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return rows[indexPath.row].selectable ? indexPath : nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        
        switch row {
        case .requestInfo:
            dismiss(animated: true, completion: nil)
//            let vc = RequestInfoViewController(election: election)
//            navigationController?.pushViewController(vc, animated: true)
        default: ()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.rows[indexPath.row]
        return row.height()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.rows[indexPath.row]
        return row.cell(for: indexPath, in: tableView)
    }
}
