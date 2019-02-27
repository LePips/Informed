//
//  CandidateElectionsCell.swift
//  Informed
//
//  Created by Ethan Pippin on 2/23/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class CandidateElectionsCell: BasicTableViewCell, NeededHeight {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var electionTitleLabel = makeElectionDateLabel()
    private lazy var electionDateLabel = makeElectionDateLabel()
    
    override func setupSubviews() {
        addSubview(titleLabel)
        addSubview(electionTitleLabel)
        addSubview(electionDateLabel)
        self.backgroundColor = .black
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor ⩵ topAnchor,
            titleLabel.leftAnchor ⩵ leftAnchor + 30
            ])
        NSLayoutConstraint.activate([
            electionTitleLabel.topAnchor ⩵ titleLabel.bottomAnchor + 6,
            electionTitleLabel.leftAnchor ⩵ leftAnchor + 30
            ])
        NSLayoutConstraint.activate([
            electionDateLabel.topAnchor ⩵ titleLabel.bottomAnchor + 6,
            electionDateLabel.rightAnchor ⩵ rightAnchor
            ])
    }
    
    static var neededHeight: CGFloat = 50
    
    func configure(with candidate: Candidate) {
        candidate.getElections { (elections) in
            DispatchQueue.main.async {
                if elections.isEmpty {
                    self.electionTitleLabel.text = "None"
                    self.electionDateLabel.text = ""
                } else {
                    self.electionTitleLabel.text = elections[0].title
                    self.electionDateLabel.text = elections[0].date
                }
            }
        }
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.text = "Elections"
        return label
    }
    
    // MARK: -
    // MARK: To be replaced with stackview for multiple elections
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
