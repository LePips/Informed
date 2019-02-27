//
//  CandidateRow.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit

protocol CandidateRowDelegate {
    func articleCell(_ cell: UITableViewCell, wasSelectedAt: IndexPath, with article: Article)
}

enum CandidateRow {
    case picture
    case name
    case attribute(Attribute)
    case elections
    case news
}

extension CandidateRow {
    static func buildRows(candidate: Candidate) -> [CandidateRow] {
        var rows: [CandidateRow] = []
        
        if let _ = candidate.coverImageString {
            rows.append(picture)
        }
        
        rows.append(.name)
        
        let party = Attribute(title: "Party", attribute: candidate.party)
        rows.append(.attribute(party))
        
        rows.append(.elections)
        rows.append(.news)
        return rows
    }
    
    func height() -> CGFloat {
        switch self {
        case .picture:
            return PictureCell.neededHeight
        case .name:
            return NameCell.neededHeight
        case .attribute:
            return AttributeCell.neededHeight
        case .elections:
            return CandidateElectionsCell.neededHeight
        case .news:
            return 128
        }
    }
    
    static func configure(_ tableView: UITableView) {
        tableView.register(PictureCell.self, forCellReuseIdentifier: PictureCell.identifier)
        tableView.register(NameCell.self, forCellReuseIdentifier: NameCell.identifier)
        tableView.register(CandidateElectionsCell.self, forCellReuseIdentifier: CandidateElectionsCell.identifier)
        tableView.register(AttributeCell.self, forCellReuseIdentifier: AttributeCell.identifier)
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func cell(for path: IndexPath, in tableView: UITableView, with candidate: Candidate, delegate: CandidateRowDelegate) -> UITableViewCell {
        switch self {
        case .picture:
            let cell = tableView.dequeueReusableCell(withIdentifier: PictureCell.identifier, for: path) as! PictureCell
            cell.configure(with: candidate.coverImageString)
            return cell
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.identifier, for: path) as! NameCell
            cell.configure(with: candidate)
            return cell
        case .attribute(let attribute):
            let cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.identifier, for: path) as! AttributeCell
            cell.configure(with: attribute)
            return cell
        case .elections:
            let cell = tableView.dequeueReusableCell(withIdentifier: CandidateElectionsCell.identifier, for: path) as! CandidateElectionsCell
            cell.configure(with: candidate)
            return cell
        case .news:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: path) as! NewsCell
            News.getFor(candidate.fullName) { (articles) in
                DispatchQueue.main.async {
                    cell.configure(with: articles, delegate: delegate)
                }
            }
            return cell
        }
    }
}
