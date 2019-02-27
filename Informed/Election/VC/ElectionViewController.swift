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

class ElectionViewController: BasicViewController {
    
    private var election: Election
    private var rows: [ElectionRow] = []
    private lazy var statusBarUnderlay: UIView = self.makeStatusBarUnderlay()
    private lazy var tableView: UITableView = self.makeTableView()
    lazy var refreshController: UIRefreshControl = makeRefreshController()
    
    override func setupSubviews() {
        view.addSubview(statusBarUnderlay)
        view.addSubview(tableView)
        view.embed(tableView)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            statusBarUnderlay.topAnchor ⩵ view.topAnchor,
            statusBarUnderlay.leftAnchor ⩵ view.leftAnchor,
            statusBarUnderlay.rightAnchor ⩵ view.rightAnchor,
            statusBarUnderlay.heightAnchor ⩵ 20
            ])
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
    
    private func makeStatusBarUnderlay() -> UIView {
        let underlay = UIView.forAutoLayout()
        underlay.backgroundColor = .white
        return underlay
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView.forAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshController
        ElectionRow.configure(tableView)
        return tableView
    }
    
    private func makeRefreshController() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    }
    
    @objc private func refresh(_ refreshControl: UIRefreshControl) {
        Election.refreshElection(id: election.id) { election in
            self.election = election
            self.rows = ElectionRow.buildRows(election: election)
            DispatchQueue.main.async {
                refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: -
// MARK: lifecycle
extension ElectionViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rows = ElectionRow.buildRows(election: election)
    }
}

// MARK: -
// MARK: tableview
extension ElectionViewController: UITableViewDataSource, UITableViewDelegate {
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
        return row.cell(for: indexPath, in: tableView, delegate: self)
    }
}

extension ElectionViewController: CandidateCourselViewDelegate {
    func candidiateViewTapped(_ view: CandidateCarouselView, candidate: Candidate) {
        let vc = CandidateViewController(with: candidate)
        navigationController?.pushViewController(vc, animated: true)
    }
}
