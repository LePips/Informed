//
//  LargeCardCell.swift
//  Informed
//
//  Created by Ethan Pippin on 8/24/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class LargeCardCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat {
        return 250
    }
    
    var election: Election!
    
    func configure(with election: Election) {
        self.election = election
        
        titleLabel.text = "Informed Placeholder"
        
        _ = holderView
        _ = titleLabel
        
        backgroundColor = UIColor.Informed.reallyDark
    }
    
    private lazy var holderView: UIView = self._holderView()
    private func _holderView() -> UIView {
        let holderView = UIView.forAutoLayout()
        
        contentView.addSubview(holderView)
        NSLayoutConstraint.activate([
            holderView.leftAnchor ⩵ contentView.leftAnchor + 10,
            holderView.rightAnchor ⩵ contentView.rightAnchor - 10,
            holderView.topAnchor ⩵ contentView.topAnchor + 10,
            holderView.bottomAnchor ⩵ contentView.bottomAnchor - 5
            ])
        
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        holderView.backgroundColor = UIColor.Informed.darkGrey
        
        return holderView
    }
    
    private lazy var titleLabel: UILabel = self._titleLabel()
    private func _titleLabel() -> UILabel {
        let titleLabel = UILabel.forAutoLayout()
        
        holderView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor ⩵ holderView.centerXAnchor,
            titleLabel.topAnchor ⩵ holderView.topAnchor,
            titleLabel.bottomAnchor ⩵ holderView.bottomAnchor,
            titleLabel.widthAnchor ⩵ holderView.widthAnchor × 0.8
            ])
        
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.baselineAdjustment = .alignCenters
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        titleLabel.textColor = UIColor.Informed.Text.grey
        titleLabel.numberOfLines = 0
        
        return titleLabel
    }
}
