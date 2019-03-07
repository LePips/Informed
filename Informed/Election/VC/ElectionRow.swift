//
//  ElectionRow.swift
//  Informed
//
//  Created by Ethan Pippin on 7/6/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit

enum ElectionRow {
    case attribute(Attribute)
    case section(String, String)
    case candidates([Int])
}

extension ElectionRow {
    static func buildRows(election: Election) -> [ElectionRow] {
        var electionRows = [ElectionRow]()
        
        if let date = election.actualDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM d, yyyy"
            let dateAttribute = Attribute(title: "Date", attribute: formatter.string(from: date))
            electionRows.append(.attribute(dateAttribute))
        }

        for section in election.sections {
            guard let title = section.keys.first else { break }
            guard let text = section.values.first else { break }
            electionRows.append(.section(title, text))
        }
        
        electionRows.append(.candidates(election.candidates))
        
        return electionRows
    }
}

extension ElectionRow {
    static func configure(_ tableView: UITableView) {
        tableView.register(AttributeCell.self, forCellReuseIdentifier: AttributeCell.identifier)
        tableView.register(SectionCell.self, forCellReuseIdentifier: SectionCell.identifier)
        tableView.register(CandidateCarouselCell.self, forCellReuseIdentifier: CandidateCarouselCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func height() -> CGFloat {
        switch self {
        case .attribute:
            return AttributeCell.neededHeight
        case .section(_, let text):
            return SectionCell.neededHeight(for: text)
        case .candidates:
            return CandidateCarouselCell.neededHeight
        }
    }
    
    func cell(for path: IndexPath, in tableView: UITableView, delegate: CandidateCourselViewDelegate) -> UITableViewCell {
        switch self {
        case .attribute(let attribute):
            let cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.identifier, for: path) as! AttributeCell
            cell.configure(with: attribute)
            return cell
        case .section(let title, let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: SectionCell.identifier, for: path) as! SectionCell
            cell.configure(with: title, text: text)
            return cell
        case .candidates(let ids):
            let cell = tableView.dequeueReusableCell(withIdentifier: CandidateCarouselCell.identifier, for: path) as! CandidateCarouselCell
            cell.configure(with: ids, delegate: delegate)
            return cell
        }
    }
}
