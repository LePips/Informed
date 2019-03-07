//
//  CandidateViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips
import SafariServices

class CandidateViewController: BasicViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private lazy var tableView: UITableView = makeTableView()
    private lazy var backButton = makeBackButton()
    private let candidate: Candidate
    private let handler = NewsCellHandler()
    private var rows: [CandidateRow] = []
    
    override func setupSubviews() {
        view.embed(tableView)
        view.addSubview(backButton)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor ⩵ view.safeAreaLayoutGuide.topAnchor + 15,
            backButton.leftAnchor ⩵ view.leftAnchor + 15,
            backButton.widthAnchor ⩵ 36,
            backButton.heightAnchor ⩵ 36
            ])
    }
    
    init(with candidate: Candidate) {
        self.candidate = candidate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView.forAutoLayout()
        CandidateRow.configure(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        return tableView
    }
    
    private func makeBackButton() -> UIButton {
        let button = UIButton.forAutoLayout()
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.setImage(UIImage.vector("Left"), for: .normal)
        button.setTitle("", for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        button.layer.cornerRadius = 18
        return button
    }
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: -
// MARK: lifecycle
extension CandidateViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBehaviors(behaviors: [HideNavigationBarBehavior(animated: true)])
        
        self.rows = CandidateRow.buildRows(candidate: candidate, handler: handler)
        view.backgroundColor = .black
        
        handler.delegate = self
        handler.getArticles(with: candidate.fullName)
        handler.getElections(with: candidate)
    }
}

// MARK: -
// MARK: tableView
extension CandidateViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    private func row(at path: IndexPath) -> CandidateRow {
        return rows[path.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.row(at: indexPath)
        return row.height()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.row(at: indexPath)
        return row.height()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.row(at: indexPath)
        return row.cell(for: indexPath, in: tableView, delegate: self, handler: self.handler)
    }
}

// MARK: -
// MARK: candidateRowDelegate
extension CandidateViewController: CandidateRowDelegate {
    func didLoadArticles() {
        self.rows = CandidateRow.buildRows(candidate: candidate, handler: handler)
        tableView.reloadData()
    }
    
    func didLoadElections() {
        self.rows = CandidateRow.buildRows(candidate: candidate, handler: handler)
        tableView.reloadData()
    }
    
    func newsCell(_ cell: NewsCell, didUpdateAt path: IndexPath) {
        tableView.beginUpdates()
        tableView.reloadRows(at: [path], with: .fade)
        tableView.endUpdates()
    }
    
    func article(_ article: Article, wasSelectedAt path: IndexPath) {
        guard let url = article.url else { return }
        let vc = SFSafariViewController(url: url)
        vc.preferredBarTintColor = .black
        present(vc, animated: true)
    }
}
