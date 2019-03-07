//
//  CandidateRow.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit

protocol CandidateRowDelegate {
    func didLoadElections()
}

enum CandidateRow {
    case picture(URL)
    case name(String)
    case info(String, String)
    case attribute(Attribute)
    case elections([Election])
    case news([Article])
    case blank
}

extension CandidateRow {
    static func buildRows(candidate: Candidate, handler: CandidateViewControllerHandler) -> [CandidateRow] {
        var rows: [CandidateRow] = []
        
        if let url = candidate.coverImage {
            rows.append(.picture(url))
        }
        
        rows.append(.name(candidate.fullName))
        
        let party = Attribute(title: "Party", attribute: candidate.party)
        rows.append(.attribute(party))
        
        for section in candidate.sections {
            guard let title = section.keys.first else { break }
            guard let text = section.values.first else { break }
            rows.append(.info(title, text))
        }
        
        rows.append(.elections(handler.elections))
        rows.append(.news(handler.articles))
        
        rows.append(.blank)
        return rows
    }
    
    func height() -> CGFloat {
        switch self {
        case .picture:
            return CoverImageCell.neededHeight
        case .name:
            return NameCell.neededHeight
        case .info(_, let text):
            return SectionCell.neededHeight(for: text)
        case .attribute:
            return AttributeCell.neededHeight
        case .elections(let elections):
            return CandidateElectionsCell.neededHeight(for: elections)
        case .news(let articles):
            return NewsCell.neededHeight(for: articles)
        case .blank:
            return BlankCell.neededHeight
        }
    }
    
    static func configure(_ tableView: UITableView) {
        tableView.register(CoverImageCell.self, forCellReuseIdentifier: CoverImageCell.identifier)
        tableView.register(NameCell.self, forCellReuseIdentifier: NameCell.identifier)
        tableView.register(CandidateElectionsCell.self, forCellReuseIdentifier: CandidateElectionsCell.identifier)
        tableView.register(AttributeCell.self, forCellReuseIdentifier: AttributeCell.identifier)
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tableView.register(SectionCell.self, forCellReuseIdentifier: SectionCell.identifier)
        tableView.register(BlankCell.self, forCellReuseIdentifier: BlankCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func cell(for path: IndexPath, in tableView: UITableView, delegate: NewsCellDelegate) -> UITableViewCell {
        switch self {
        case .picture(let image):
            let cell = tableView.dequeueReusableCell(withIdentifier: CoverImageCell.identifier, for: path) as! CoverImageCell
            cell.configure(with: image)
            return cell
        case .name(let name):
            let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.identifier, for: path) as! NameCell
            cell.configure(with: name)
            return cell
        case .attribute(let attribute):
            let cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.identifier, for: path) as! AttributeCell
            cell.configure(with: attribute)
            return cell
        case .elections(let elections):
            let cell = tableView.dequeueReusableCell(withIdentifier: CandidateElectionsCell.identifier, for: path) as! CandidateElectionsCell
            cell.configure(with: elections)
            return cell
        case .news(let articles):
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: path) as! NewsCell
            cell.configure(with: delegate, articles: articles)
            return cell
        case .info(let title, let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: SectionCell.identifier, for: path) as! SectionCell
            cell.configure(with: title, text: text)
            return cell
        case .blank:
            let cell = tableView.dequeueReusableCell(withIdentifier: BlankCell.identifier, for: path) as! BlankCell
            return cell
        }
    }
}
