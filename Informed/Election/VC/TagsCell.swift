//
//  TagsCell.swift
//  Informed
//
//  Created by Ethan Pippin on 9/26/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class TagsCell: BasicTableViewCell {
    static var neededHeight: CGFloat {
        return 40
    }
    
    func configure() {
        _ = leftTag
        _ = rightTag
        
        leftTag.text = "National"
        rightTag.text = "Featured"
        
    }
    
    private lazy var leftTag: UILabel = self._leftTag()
    private func _leftTag() -> UILabel {
        let label = UILabel.forAutoLayout()
        
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor ⩵ contentView.leftAnchor + UI.padding,
            label.topAnchor ⩵ contentView.topAnchor + 20
            ])
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(hex: 0x9B9B9B)
        
        return label
    }
    
    private lazy var rightTag: UILabel = self._rightTag()
    private func _rightTag() -> UILabel {
        let label = UILabel.forAutoLayout()
        
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.rightAnchor ⩵ contentView.rightAnchor - UI.padding,
            label.topAnchor ⩵ contentView.topAnchor + 20
            ])
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(hex: 0x9B9B9B)
        
        return label
    }
}
