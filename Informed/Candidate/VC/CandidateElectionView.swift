//
//  CandidateElectionView.swift
//  Informed
//
//  Created by Ethan Pippin on 3/7/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class CandidateElectionView: BasicView, NeededHeight {
    
    private lazy var electionTitleLabel = makeElectionTitleLabel()
    private lazy var electionDateLabel = makeElectionDateLabel()
    
    func configure(with election: Election) {
        self.electionTitleLabel.text = election.title
        self.electionDateLabel.text = election.actualDate?.year
    }
    
    override func setupSubviews() {
        addSubview(electionTitleLabel)
        addSubview(electionDateLabel)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            electionTitleLabel.centerYAnchor ⩵ centerYAnchor,
            electionTitleLabel.leftAnchor ⩵ leftAnchor + Metrics.CellInsets.leftPadding
            ])
        NSLayoutConstraint.activate([
            electionDateLabel.centerYAnchor ⩵ centerYAnchor,
            electionDateLabel.rightAnchor ⩵ rightAnchor - Metrics.CellInsets.rightPadding
            ])
    }
    
    static var neededHeight: CGFloat = 50
    
    private func makeElectionTitleLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }
    
    private func makeElectionDateLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.Informed.Text.grey
        return label
    }
}
