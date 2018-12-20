//
//  WatchingElectionRow.swift
//  Informed
//
//  Created by Ethan Pippin on 9/5/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

//import UIKit
//import SharedPips
//
//enum WatchingElectionRow {
//}
//
//extension WatchingElectionRow {
//    static func buildRows() -> [HomeRow] {
//        var rows: [HomeRow] = []
//        
//        let elections = ElectionState.core.state.watching
//        
//        if elections.isEmpty {
//            let row = HomeRow.text("No watching elections")
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
//        header.configure(with: "Watching")
//        return header.contentView
//    }
//}
