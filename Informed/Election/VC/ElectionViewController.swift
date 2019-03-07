//
//  ElectionViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips
import SafariServices

class ElectionViewController: BasicViewController {
    
    private lazy var tableView: UITableView = self.makeTableView()
    private lazy var refreshController: UIRefreshControl = makeRefreshController()
    private var election: Election
    private let handler = ElectionViewControllerHandler()
    private var rows: [ElectionRow] = []
    
    override func setupSubviews() {
        view.addSubview(tableView)
        view.embed(tableView)
    }
    
    override func setupLayoutConstraints() {
    }
    
    init(with election: Election) {
        self.election = election
        super.init(nibName: nil, bundle: nil)
        title = election.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView.forAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshController
        tableView.backgroundColor = .black
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
            self.rows = ElectionRow.buildRows(election: election, handler: self.handler)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Informed.reallyDark
        self.rows = ElectionRow.buildRows(election: election, handler: handler)
        handler.newsCellDelegate = self
        handler.getArticles(with: election.title)
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
        return row.cell(for: indexPath, in: tableView, candidateDelegate: self, newsDelegate: self)
    }
}

// MARK: -
// MARK: candidateCarouselViewDelegate
extension ElectionViewController: CandidateCourselViewDelegate {
    func candidiateViewTapped(_ view: CandidateCarouselView, candidate: Candidate) {
        let vc = CandidateViewController(with: candidate)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: -
// MARK: newsCellDelegate
extension ElectionViewController: NewsCellDelegate {
    func didLoadArticles() {
        self.rows = ElectionRow.buildRows(election: election, handler: handler)
        tableView.reloadData()
    }
    
    func articleWasSelected(_ article: Article) {
        guard let url = article.url else { return }
        let vc = SFSafariViewController(url: url)
        vc.preferredBarTintColor = .black
        present(vc, animated: true)
    }
}
