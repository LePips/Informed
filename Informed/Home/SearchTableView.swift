//
//  SearchTableView.swift
//  Informed
//
//  Created by Ethan Pippin on 9/16/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class SearchTableView: UIView {
    
    private var rows: [String] = []
    private var searched: [String] = []
    private var searching = false

    private lazy var searchBar: UISearchBar = self._searchBar()
    private func _searchBar() -> UISearchBar {
        let searchBar = UISearchBar.forAutoLayout()
        
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor ⩵ safeAreaLayoutGuide.topAnchor,
            searchBar.leftAnchor ⩵ leftAnchor,
            searchBar.rightAnchor ⩵ rightAnchor,
            searchBar.heightAnchor ⩵ 50
            ])
        
        searchBar.delegate = self
        searchBar.placeholder = "2016 Presidential Election"
        
        return searchBar
    }
    
    private lazy var tableView: UITableView = self._tableView()
    private func _tableView() -> UITableView {
        let tableView = UITableView.forAutoLayout()
        
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor ⩵ searchBar.bottomAnchor,
            tableView.leftAnchor ⩵ leftAnchor,
            tableView.rightAnchor ⩵ rightAnchor,
            tableView.bottomAnchor ⩵ bottomAnchor
            ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }
    
    func configure() {
        _ = searchBar
        _ = tableView
        
        ElectionState.core.addSubscriber(subscriber: self, update: SearchTableView.update)
    }
    
    func close() {
        searchBar.resignFirstResponder()
    }
    
}

extension SearchTableView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searched = rows.filter { $0.prefix(searchText.count) == searchText }
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.resignFirstResponder()
    }
}

extension SearchTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searched.count
        } else {
            return rows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if searching {
            cell.textLabel?.text = searched[indexPath.row]
        } else {
            cell.textLabel?.text = rows[indexPath.row]
        }
        
        return cell
    }
}

extension SearchTableView: Subscriber {
    func update(with state: ElectionState) {
        self.rows = state.elections.map { $0.title }
        tableView.reloadData()
    }
}
