//
//  OptionTableViewHandler.swift
//  Informed
//
//  Created by Ethan Pippin on 11/17/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

enum OptionRow {
    case about
    case requestInfo
    case settings
    
    static var height: CGFloat = 55
    
    func presenting() -> UIViewController {
        switch self {
        case .about:
            return AboutViewController()
        case .requestInfo:
            return RequestInfoViewController()
        case .settings:
            return SettingsViewController()
        }
    }
}

class OptionTableViewHandler {
    
    private(set) var rows: [OptionRow] = []
    
    func buildRows() {
        rows = [.about, .requestInfo, .settings]
    }
    
    static func configure(_ tableView: UITableView) {
        tableView.register(SideSheetOptionViewCell.self, forCellReuseIdentifier: SideSheetOptionViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func cell(for path: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let row = rows[path.row]
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: path)
//        cell.textLabel?.text = String(describing: row)
//        cell.selectionStyle = .none
//        return cell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: SideSheetOptionViewCell.identifier, for: path) as! SideSheetOptionViewCell
        switch row {
        case .about:
            let cell = tableView.dequeueReusableCell(withIdentifier: SideSheetOptionViewCell.identifier, for: path) as! SideSheetOptionViewCell
            let image = UIImage.named("Home")
            let title = "About"
            cell.configure(with: image, title: title)
            return cell
        case .requestInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: SideSheetOptionViewCell.identifier, for: path) as! SideSheetOptionViewCell
            let image = UIImage.named("Request Info")
            let title = "Request Info"
            cell.configure(with: image, title: title)
            return cell
        case .settings:
            let cell = tableView.dequeueReusableCell(withIdentifier: SideSheetOptionViewCell.identifier, for: path) as! SideSheetOptionViewCell
            let image = UIImage.named("Request Info")
            let title = "Settings"
            cell.configure(with: image, title: title)
            return cell
        }
//        return cell
    }
}
