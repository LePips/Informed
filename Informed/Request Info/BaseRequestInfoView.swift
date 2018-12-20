//
//  BaseRequestInfoView.swift
//  Informed
//
//  Created by Ethan Pippin on 10/19/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class BaseRequestInfoView: UIView {
    
    var tableView: UITableView
    
    override init(frame: CGRect) {
        self.tableView = UITableView()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
