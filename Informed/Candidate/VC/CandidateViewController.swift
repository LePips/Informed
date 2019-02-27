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
    
    private let candidate: Candidate
    private var rows: [CandidateRow] = []
    private lazy var tableView: UITableView = makeTableView()
    private lazy var backButton = makeBackButton()
    
    override func setupSubviews() {
        view.embed(tableView)
        view.addSubview(backButton)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor ⩵ view.safeAreaLayoutGuide.topAnchor + 15,
            backButton.leftAnchor ⩵ view.leftAnchor + 15,
            backButton.widthAnchor ⩵ 35,
            backButton.heightAnchor ⩵ 35
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
        button.backgroundColor = .white
        return button
    }
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: -
// MARK: lifecycle
extension CandidateViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rows = CandidateRow.buildRows(candidate: candidate)
        view.backgroundColor = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        return row.cell(for: indexPath, in: tableView, with: candidate, delegate: self)
    }
}

// MARK: -
// MARK: candidateRowDelegate
extension CandidateViewController: CandidateRowDelegate {
    func articleCell(_ cell: UITableViewCell, wasSelectedAt: IndexPath, with article: Article) {
        guard let url = article.url else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
}
