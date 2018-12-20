//
//  QuestionCell.swift
//  Informed
//
//  Created by Ethan Pippin on 10/19/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class QuestionCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat {
        return 100
    }
    
    func configure(with question: String) {
        label.text = question
        
        _ = label
    }
    
    private lazy var label: UILabel = self.makeLabel()
    private func makeLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor ⩵ contentView.centerYAnchor,
            label.leftAnchor ⩵ contentView.leftAnchor + 20
            ])
        
        label.setFont(.semibold, size: 24)
        
        return label
    }
    
}
