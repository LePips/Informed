//
//  HomeElectionCell.swift
//  Informed
//
//  Created by Ethan Pippin on 9/5/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class HomeElectionCell: BasicTableViewCell {
    
    private lazy var colorView: UIView = makeColorView()
    private lazy var titleLabel: UILabel = makeTitleLabel()
    
    static var neededHeight: CGFloat {
        return 65
    }
    
    func configure(with election: Election) {
        titleLabel.text = election.title
    }
    
    override func setupSubviews() {
        contentView.addSubview(colorView)
        contentView.addSubview(titleLabel)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            colorView.leftAnchor ⩵ contentView.leftAnchor + 12,
            colorView.rightAnchor ⩵ contentView.rightAnchor - 12,
            colorView.bottomAnchor ⩵ contentView.bottomAnchor,
            colorView.topAnchor ⩵ contentView.topAnchor + 15
            ])
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor ⩵ colorView.centerYAnchor,
            titleLabel.leftAnchor ⩵ colorView.leftAnchor + 15
            ])
    }
    
    private func makeColorView() -> UIView {
        let colorView = UIView.forAutoLayout()
//        colorView.backgroundColor = UIColor(hex: 0xEEEEEE)
        colorView.layer.cornerRadius = 8
        return colorView
    }
    
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel.forAutoLayout()
        titleLabel.setFont(.regular, size: 20)
        return titleLabel
    }

}
