//
//  CurrentPositionCell.swift
//  Informed
//
//  Created by Ethan Pippin on 2/23/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class CurrentPositionCell: BasicTableViewCell, NeededHeight {
    
    private lazy var currentPositionLabel = makeCurrentPositionLabel()
    
    override func setupSubviews() {
        addSubview(currentPositionLabel)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            currentPositionLabel.centerXAnchor ⩵ centerXAnchor,
            currentPositionLabel.centerYAnchor ⩵ centerYAnchor,
            currentPositionLabel.widthAnchor ⩵ widthAnchor × 0.42
            ])
    }
    
    static var neededHeight: CGFloat = 45
    
    func configure(with candidate: Candidate) {
    }
    
    private func makeCurrentPositionLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor.Informed.Text.grey
        return label
    }
}
