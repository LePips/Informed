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
    
    private lazy var titleLabel: UILabel = makeTitleLabel()
    
    static var neededHeight: CGFloat {
        return 65
    }
    
    func configure(with election: Election) {
        titleLabel.text = election.title
    }
    
    override func setupSubviews() {
        contentView.addSubview(titleLabel)
        backgroundColor = UIColor.Informed.reallyDark
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor ⩵ centerYAnchor,
            titleLabel.leftAnchor ⩵ leftAnchor + 22
            ])
    }
    
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel.forAutoLayout()
        titleLabel.setFont(.regular, size: 20)
        titleLabel.textColor = .white
        return titleLabel
    }
}
