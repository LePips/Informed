//
//  TitleCell.swift
//  Informed
//
//  Created by Ethan Pippin on 7/6/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class TitleCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat {
        return 50
    }
    
    func configure(with title: String) {
        label.text = title
    }
    
    private lazy var label: UILabel = self._label()
    private func _label() -> UILabel {
        let label = UILabel.forAutoLayout()
        
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor ⩵ contentView.centerYAnchor,
            label.leftAnchor ⩵ contentView.leftAnchor + UI.padding
            ])
        
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .black
        
        return label
    }
}
