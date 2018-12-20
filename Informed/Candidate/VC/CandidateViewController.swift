//
//  CandidateViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class CandidateViewController: UIViewController {
    
    let candidate: Candidate!
    var rows = [CandidateRow]()
    
    init(with candidate: Candidate) {
        self.candidate = candidate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = self._tableView()
    private func _tableView() -> UITableView {
        let tableView = UITableView.forAutoLayout()
        
        view.embed(tableView)
        
        CandidateRow.configure(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        return tableView
    }
    
    private lazy var closeButton: UIButton = self._closeButton()
    private func _closeButton() -> UIButton {
        let closeButton = UIButton.forAutoLayout()
        
        let bounds: CGFloat = 60
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.centerXAnchor ⩵ view.centerXAnchor,
            closeButton.bottomAnchor ⩵ view.bottomAnchor - 20,
            closeButton.widthAnchor ⩵ bounds,
            closeButton.heightAnchor ⩵ bounds
            ])
        
        closeButton.setTitle("", for: .normal)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.layer.cornerRadius = bounds / 2
        closeButton.backgroundColor = UIColor.Material.red100
        
        return closeButton
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: -
// MARK: lifecycle
extension CandidateViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CandidateState.core.addSubscriber(subscriber: self, update: CandidateViewController.update)
        
        self.rows = CandidateRow.buildRows(candidate: candidate)
        setupViews()
    }
    
    private func setupViews() {
        _ = tableView
        _ = closeButton
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
        return row.cell(for: indexPath, in: tableView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells.compactMap({ $0 as? PictureCell }) {
            cell.setBackgroundOffset(offset: offset(path: IndexPath(row: 0, section: 0)))
        }
    }
    
    private func offset(path: IndexPath) -> CGFloat {
        let cellFrame = tableView.rectForRow(at: path)
        let cellFrameInTable = tableView.convert(cellFrame, to: tableView.superview)
        let cellOffset = cellFrameInTable.origin.y + cellFrameInTable.size.height
        let tableHeight = tableView.bounds.height + cellFrameInTable.height
        let cellOffsetFactor = cellOffset / tableHeight
        return cellOffsetFactor
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        for cell in tableView.visibleCells.compactMap({ $0 as? PictureCell }) {
            cell.setBackgroundOffset(offset: offset(path: IndexPath(row: 0, section: 0)))
        }
    }
}

// MARK: -
// MARK: subscriber
extension CandidateViewController: Subscriber {
    func update(with state: CandidateState) {
        if state.candidates.isEmpty {
            return
        }
        self.rows = CandidateRow.buildRows(candidate: state.candidates[0])
        tableView.reloadData()
    }
}
