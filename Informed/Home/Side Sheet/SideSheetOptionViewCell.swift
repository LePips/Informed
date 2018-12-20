//
//  SideSheetOptionView.swift
//  Informed
//
//  Created by Ethan Pippin on 11/17/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class SideSheetOptionViewCell: BasicTableViewCell {
    
    private lazy var iconView: UIImageView = makeIconView()
    private lazy var titleLabel: UILabel = makeTitleLabel()
    
    func configure(with icon: UIImage, title: String) {
        iconView.image = icon
        titleLabel.text = title
    }
    
    override func setupSubviews() {
//        addSubview(iconView)
        addSubview(titleLabel)
    }
    
    override func setupLayoutConstraints() {
//        NSLayoutConstraint.activate([
//            iconView.leftAnchor ⩵ contentView.leftAnchor + 15,
//            iconView.bottomAnchor ⩵ contentView.bottomAnchor
//            ])
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor ⩵ contentView.leftAnchor + 20,
            titleLabel.centerYAnchor ⩵ contentView.centerYAnchor + 27
            ])
    }
    
    private func makeIconView() -> UIImageView {
        let iconView = UIImageView.forAutoLayout()
        return iconView
    }
    
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel.forAutoLayout()
        titleLabel.setFont(.medium, size: 26)
        return titleLabel
    }
}
