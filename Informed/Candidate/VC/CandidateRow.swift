//
//  CandidateRow.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import Kingfisher

enum CandidateRow {
    case picture(String?)
    case name(String)
    case bio(String)
}

extension CandidateRow {
    static func buildRows(candidate: Candidate) -> [CandidateRow] {
        var rows = [CandidateRow]()
        
        let picture = CandidateRow.picture(candidate.imageString)
        rows.append(picture)
        
        let name = CandidateRow.name(candidate.name)
        rows.append(name)
        
        let bio = CandidateRow.bio(candidate.bio)
        rows.append(bio)
        
        return rows
    }
    
    func height() -> CGFloat {
        switch self {
        case .picture:
            return PictureCell.neededHeight
        case .name:
            return NameCell.neededHeight
        case .bio:
            return 50
        }
    }
    
    static func configure(_ tableView: UITableView) {
        tableView.register(PictureCell.self, forCellReuseIdentifier: PictureCell.identifier)
        tableView.register(NameCell.self, forCellReuseIdentifier: NameCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func cell(for path: IndexPath, in tableView: UITableView) -> UITableViewCell {
        switch self {
        case .picture(let imageString):
            let cell = tableView.dequeueReusableCell(withIdentifier: PictureCell.identifier, for: path) as! PictureCell
            cell.configure(with: imageString)
            return cell
        case .name(let name):
            let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.identifier, for: path) as! NameCell
            cell.configure(with: name)
            return cell
        case .bio(let bio):
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: path)
            cell.textLabel?.text = bio
            return cell
        }
    }
    
    func setParralax(for path: IndexPath, in tableView: UITableView) {
        switch self {
        case .picture:
            ()
        default: ()
        }
    }
}
