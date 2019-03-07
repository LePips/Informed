//
//  BlankCell.swift
//  Informed
//
//  Created by Ethan Pippin on 3/7/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class BlankCell: BasicTableViewCell, NeededHeight {
    
    override func setupSubviews() {
        backgroundColor = .black
    }
    
    override func setupLayoutConstraints() {
    }
    
    static var neededHeight: CGFloat = 50
    
}
