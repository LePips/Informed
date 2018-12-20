//
//  NationalElectionRow.swift
//  Informed
//
//  Created by Ethan Pippin on 9/5/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

enum NationalElectionRow {
}

extension NationalElectionRow {
    static func buildRows() -> [HomeRow] {
        var rows: [HomeRow] = []
        
        let elections = ElectionState.core.state.nationalElections
        
        let sectionTitle = HomeRow.sectionTitle("National", elections.count > 3)
        rows.append(sectionTitle)
        rows.append(.divider)
        
        for election in elections {
            let row = HomeRow.election(election)
            rows.append(row)
        }
        
        return rows
    }
    
    static func header(_ tableView: UITableView) -> UIView {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: LargeTitleHeader.identifier) as! LargeTitleHeader
        header.configure(with: "National")
        return header.contentView
    }
}
