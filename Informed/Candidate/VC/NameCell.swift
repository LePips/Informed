//
//  NameCell.swift
//  Informed
//
//  Created by Ethan Pippin on 6/8/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class NameCell: BasicTableViewCell, NeededHeight {
    
    private lazy var nameLabel: UILabel = makeNameLabel()
    
    override func setupSubviews() {
        addSubview(nameLabel)
        self.backgroundColor = .black
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor ⩵ centerXAnchor,
            nameLabel.centerYAnchor ⩵ centerYAnchor
            ])
    }
    
    static var neededHeight: CGFloat = 60
    
    func configure(with name: String) {
        self.nameLabel.text = name
    }
    
    private func makeNameLabel() -> UILabel {
        let nameLabel = UILabel.forAutoLayout()
        nameLabel.font = UIFont.systemFont(ofSize: 42, weight: .semibold)
        nameLabel.textColor = UIColor.Informed.Text.white
        return nameLabel
    }
}
