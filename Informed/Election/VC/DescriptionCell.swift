//
//  DescriptionCell.swift
//  Informed
//
//  Created by Ethan Pippin on 9/18/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import SharedPips

class DescriptionCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func configure(with description: Description) {
        label.text = description.description()
    }
    
    private lazy var label: UILabel = self._label()
    private func _label() -> UILabel {
        let label = UILabel.forAutoLayout()
        
        let inset = UIEdgeInsetsMake(1, 8, 1, 8)
        contentView.embed(label, inset: inset)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }
}
