//
//  HomeTableViewHandler.swift
//  Informed
//
//  Created by Ethan Pippin on 11/10/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import UIKit

enum HomeRow {
    case largeCard
    case sectionTitle(String, Bool)
    case election(Election)
    case divider

    func height() -> CGFloat {
        switch self {
        case .largeCard:
            return LargeCardCell.neededHeight
        case .sectionTitle:
            return SectionTitleCell.neededHeight
        case .election:
            return HomeElectionCell.neededHeight
        case .divider:
            return DividerCell.neededHeight
        }
    }
}

class HomeTableViewHandler {
    
    private(set) var sections: [[HomeRow]] = []
    
    func buildRows() {
        sections = []
        
        let sectionOne: [HomeRow] = [.largeCard]
        sections.append(sectionOne)
        
        let nationalElectionRows = NationalElectionRow.buildRows()
        sections.append(nationalElectionRows)
        let stateElectionRows = StateElectionRow.buildRows()
        sections.append(stateElectionRows)
    }
    
    static func configure(_ tableView: UITableView) {
        tableView.register(LargeCardCell.self, forCellReuseIdentifier: LargeCardCell.identifier)
        tableView.register(SectionTitleCell.self, forCellReuseIdentifier: SectionTitleCell.identifier)
        tableView.register(HomeElectionCell.self, forCellReuseIdentifier: HomeElectionCell.identifier)
        tableView.register(DividerCell.self, forCellReuseIdentifier: DividerCell.identifier)
        
        tableView.register(LargeTitleHeader.self, forHeaderFooterViewReuseIdentifier: LargeTitleHeader.identifier)
    }
    
    func row(for path: IndexPath) -> HomeRow {
        let section = sections[path.section]
        let row = section[path.row]
        return row
    }
    
    static func header(for section: Int, in tableView: UITableView) -> UIView? {
        switch section {
        case 1:
            return NationalElectionRow.header(tableView)
        case 2:
            return StateElectionRow.header(tableView)
        default:
            return nil
        }
    }
    
    func cell(for path: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let row = self.row(for: path)
        switch row {
        case .largeCard:
            let cell = tableView.dequeueReusableCell(withIdentifier: LargeCardCell.identifier, for: path) as! LargeCardCell
            cell.configure(with: Election.single())
            return cell
        case .sectionTitle(let title, let showSeeMore):
            let cell = tableView.dequeueReusableCell(withIdentifier: SectionTitleCell.identifier, for: path) as! SectionTitleCell
            cell.configure(with: title, showSeeMore: showSeeMore)
            return cell
        case .election(let election):
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeElectionCell.identifier, for: path) as! HomeElectionCell
            cell.configure(with: election)
            return cell
        case .divider:
            let cell = tableView.dequeueReusableCell(withIdentifier: DividerCell.identifier, for: path) as! DividerCell
            cell.configure()
            return cell
        }
    }
    
    func didSelectRow(at path: IndexPath, action: (UIViewController) -> ()) {
        let row = self.row(for: path)
        var vc = UIViewController()
        switch row {
        case .largeCard:
            guard let election = ElectionState.core.state.featuredElection else { return }
            vc = ElectionViewController(with: election)
            action(vc)
        case .election(let election):
            vc = ElectionViewController(with: election)
            action(vc)
        default: ()
        }
    }
}
