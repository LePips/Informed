//
//  AttributeCell.swift
//  Informed
//
//  Created by Ethan Pippin on 2/23/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

struct Attribute {
    var title: String
    var attribute: String
}

class AttributeCell: BasicTableViewCell, NeededHeight {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var attributeLabel = makeAttributeLabel()
    
    func configure(with attribute: Attribute) {
        titleLabel.text = attribute.title
        attributeLabel.text = attribute.attribute
    }
    
    override func setupSubviews() {
        addSubview(titleLabel)
        addSubview(attributeLabel)
        backgroundColor = .black
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor ⩵ topAnchor + 5,
            titleLabel.leftAnchor ⩵ leftAnchor + 32
            ])
        NSLayoutConstraint.activate([
            attributeLabel.topAnchor ⩵ titleLabel.bottomAnchor + 3,
            attributeLabel.leftAnchor ⩵ leftAnchor + 32
            ])
    }
    
    static var neededHeight: CGFloat = 50
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.Informed.Text.grey
        return label
    }
    
    private func makeAttributeLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        label.textColor = UIColor.Informed.Text.white
        return label
    }
}
