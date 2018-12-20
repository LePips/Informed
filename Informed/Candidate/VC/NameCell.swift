//
//  NameCell.swift
//  Informed
//
//  Created by Ethan Pippin on 6/8/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class NameCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat {
        return 30
    }
    
    func configure(with name: String) {
        _ = nameLabel
        
        self.nameLabel.text = name
    }
    
    private lazy var nameLabel: UILabel = self._nameLabel()
    private func _nameLabel() -> UILabel {
        let nameLabel = UILabel.forAutoLayout()
        
        contentView.embed(nameLabel)
        
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        nameLabel.text = ""
        nameLabel.textColor = .black
        
        return nameLabel
    }
}
