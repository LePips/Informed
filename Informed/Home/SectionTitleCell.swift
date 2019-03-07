//
//  SectionTitleCell.swift
//  Informed
//
//  Created by Ethan Pippin on 11/16/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class SectionTitleCell: BasicTableViewCell {
    
    private lazy var titleLabel: UILabel = makeTitleLabel()
    private lazy var seeMoreLabel: UILabel = makeSeeMoreLabel()
    
    static var neededHeight: CGFloat {
        return 80
    }
    
    func configure(with title: String, showSeeMore: Bool) {
        titleLabel.text = title
        seeMoreLabel.isHidden = !showSeeMore
    }
    
    override func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(seeMoreLabel)
        backgroundColor = UIColor.Informed.reallyDark
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor ⩵ contentView.leftAnchor + 12,
            titleLabel.bottomAnchor ⩵ contentView.bottomAnchor - 11
            ])
        NSLayoutConstraint.activate([
            seeMoreLabel.rightAnchor ⩵ contentView.rightAnchor - 12,
            seeMoreLabel.centerYAnchor ⩵ titleLabel.centerYAnchor
            ])
    }
    
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel.forAutoLayout()
        titleLabel.setFont(.medium, size: 36)
        titleLabel.textColor = .white
        return titleLabel
    }
    
    private func makeSeeMoreLabel() -> UILabel {
        let seeMoreLabel = UILabel.forAutoLayout()
        seeMoreLabel.setFont(.regular, size: 12)
        seeMoreLabel.textColor = UIColor.Informed.selectableBlue
        seeMoreLabel.text = "SEE MORE"
        return seeMoreLabel
    }
}
