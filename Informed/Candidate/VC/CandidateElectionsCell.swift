//
//  CandidateElectionsCell.swift
//  Informed
//
//  Created by Ethan Pippin on 2/23/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class CandidateElectionsCell: BasicTableViewCell {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var electionStackView = makeElectionStackView()
    
    func configure(with elections: [Election]) {
        if electionStackView.subviews.count > 0 { return }
        for election in elections {
            let view = CandidateElectionView.forAutoLayout()
            view.configure(with: election)
            electionStackView.addArrangedSubview(view)
            NSLayoutConstraint.activate([
                view.leftAnchor ⩵ leftAnchor,
                view.rightAnchor ⩵ rightAnchor,
                view.heightAnchor ⩵ CandidateElectionView.neededHeight
                ])
        }
    }
    
    override func setupSubviews() {
        addSubview(titleLabel)
        addSubview(electionStackView)
        self.backgroundColor = .black
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor ⩵ topAnchor + Metrics.CellInsets.topPadding,
            titleLabel.leftAnchor ⩵ leftAnchor + Metrics.CellInsets.leftPadding
            ])
        NSLayoutConstraint.activate([
            electionStackView.topAnchor ⩵ titleLabel.bottomAnchor + 6,
            electionStackView.bottomAnchor ⩵ bottomAnchor,
            electionStackView.leftAnchor ⩵ leftAnchor,
            electionStackView.rightAnchor ⩵ rightAnchor
            ])
    }
    
    static func neededHeight(for elections: [Election]) -> CGFloat {
        let base: CGFloat = 52
        let electionsHeight = CGFloat(elections.count) * CandidateElectionView.neededHeight
        return base + electionsHeight
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel.header()
        label.text = "Elections"
        return label
    }
    
    private func makeElectionStackView() -> UIStackView {
        let stackView = UIStackView.forAutoLayout()
        stackView.alignment = .bottom
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }
}
