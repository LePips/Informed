//
//  LocalElectionRow.swift
//  Informed
//
//  Created by Ethan Pippin on 9/5/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

//import UIKit
//import SharedPips
//
//enum LocalElectionRow {
//}
//
//extension LocalElectionRow {
//    static func buildRows() -> [HomeRow] {
//        var rows: [HomeRow] = []
//
//        let elections = ElectionState.core.state.localElections
//        
//        if elections.isEmpty {
//            let row = HomeRow.text("No local elections")
//            rows.append(row)
//        } else {
//            for election in elections {
//                let row = HomeRow.election(election)
//                rows.append(row)
//            }
//        }
//        
//        return rows
//    }
//    
//    static func header(_ tableView: UITableView) -> UIView {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: LargeTitleHeader.identifier) as! LargeTitleHeader
//        header.configure(with: "Local")
//        return header.contentView
//    }
//}
