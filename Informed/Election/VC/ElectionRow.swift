//
//  ElectionRow.swift
//  Informed
//
//  Created by Ethan Pippin on 7/6/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

typealias Tag = (String, String?)

enum ElectionRow {
    case picture(String?)
    case tags
    case header(String)
    case divider
    case date
    case description(Description)
    case info(Info)
    case requestInfo
    
    var expandable: Bool {
        switch self {
        default:
            return false
        }
    }
    
    var selectable: Bool {
        switch self {
        case .requestInfo, .info, .date:
            return true
        default:
            return false
        }
    }
}

extension ElectionRow {
    static func buildRows(election: Election) -> [ElectionRow] {
        var electionRows = [ElectionRow]()
        
        let url = election.coverImageUrl
        let pictureRow = ElectionRow.picture(url)
        electionRows.append(pictureRow)
        
        let tagsRow = ElectionRow.tags
        electionRows.append(tagsRow)
        
        let title = election.title
        let headerRow = ElectionRow.header(title)
        electionRows.append(headerRow)
        
//        electionRows.append(.divider)
        
        let date = ElectionRow.date
        electionRows.append(date)
        
        electionRows.append(.divider)
        
        for section in election.info {
            electionRows.append(.info(section.value))
        }
        
        electionRows.append(.divider)
        electionRows.append(.requestInfo)
        
        return electionRows
    }
}

extension ElectionRow {
    static func configure(_ tableView: UITableView) {
        tableView.register(PictureCell.self, forCellReuseIdentifier: PictureCell.identifier)
        tableView.register(TagsCell.self, forCellReuseIdentifier: TagsCell.identifier)
        tableView.register(DividerCell.self, forCellReuseIdentifier: DividerCell.identifier)
        tableView.register(DateCell.self, forCellReuseIdentifier: DateCell.identifier)
        tableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.identifier)
        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
        tableView.register(RequestInfoCell.self, forCellReuseIdentifier: RequestInfoCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func height() -> CGFloat {
        switch self {
        case .picture:
            return PictureCell.neededHeight
        case .header:
            return TitleCell.neededHeight
        case .tags:
            return TagsCell.neededHeight
        case .date:
            return DateCell.neededHeight
        case .divider:
            return DividerCell.neededHeight
        case .info:
            return InfoCell.neededHeight
        case .description:
            return DescriptionCell.neededHeight
        case .requestInfo:
            return RequestInfoCell.neededHeight
        }
    }
    
    func cell(for path: IndexPath, in tableView: UITableView) -> UITableViewCell {
        switch self {
        case .picture(let url):
            let cell = tableView.dequeueReusableCell(withIdentifier: PictureCell.identifier, for: path) as! PictureCell
            cell.configure(with: url)
            return cell
        case .tags:
            let cell = tableView.dequeueReusableCell(withIdentifier: TagsCell.identifier, for: path) as! TagsCell
            cell.configure()
            return cell
        case .divider:
            let cell = tableView.dequeueReusableCell(withIdentifier: DividerCell.identifier, for: path) as! DividerCell
            cell.configure()
            return cell
        case .date:
            let cell = tableView.dequeueReusableCell(withIdentifier: DateCell.identifier, for: path) as! DateCell
            cell.configure()
            return cell
        case .header(let title):
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: path) as! TitleCell
            cell.configure(with: title)
            return cell
        case .description(let description):
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: path) as! DescriptionCell
            cell.configure(with: description)
            return cell
        case .info(let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: path) as! InfoCell
            cell.configure(with: info)
            return cell
        case .requestInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: RequestInfoCell.identifier, for: path) as! RequestInfoCell
            cell.configure()
            return cell
        }
    }
}
