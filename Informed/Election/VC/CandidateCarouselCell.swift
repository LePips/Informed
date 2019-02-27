//
//  CandidateCarouselCell.swift
//  Informed
//
//  Created by Ethan Pippin on 1/22/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

protocol CandidateCourselViewDelegate: class, CategoryViewProtocol {
    func candidiateViewTapped(_ view: CandidateCarouselView, candidate: Candidate)
}

class CandidateCarouselCell: CategoryTableViewCell {
    
    func configure(with ids: [Int], delegate: CandidateCourselViewDelegate) {
        Candidate.getCandidates(ids) { (candidates) in
            self.configureViewsWith(candidates, delegate: delegate)
        }
    }
    
    private func configureViewsWith(_ candidates: [Candidate], delegate: CandidateCourselViewDelegate) {
        DispatchQueue.main.sync {
            var views: [UIView] = []
            for candidate in candidates {
                let view = CandidateCarouselView()
                view.configure(with: candidate, delegate: delegate)
                views.append(view)
            }
            super.configure(with: views)
        }
    }
}

class CandidateCarouselView: BasicView {
    
    private lazy var initialLabel = makeInitialLabel()
    private lazy var tapGestureRecognizer = makeTapGestureRecognizer()
    private var delegate: CandidateCourselViewDelegate?
    private var candidate: Candidate?
    
    override func setupSubviews() {
        addSubview(initialLabel)
        addGestureRecognizer(tapGestureRecognizer)
        backgroundColor = UIColor.Material.grey50
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            initialLabel.centerXAnchor ⩵ centerXAnchor,
            initialLabel.centerYAnchor ⩵ centerYAnchor
            ])
    }
    
    func configure(with candidate: Candidate, delegate: CandidateCourselViewDelegate) {
        let first = candidate.first.first
        let last = candidate.last.first
        let initials = String(describing: first!).capitalized + String(describing: last!).capitalized
        initialLabel.text = initials
        
        self.delegate = delegate
        self.candidate = candidate
    }
    
    private func makeInitialLabel() -> UILabel {
        let initialLabel = UILabel.forAutoLayout()
        initialLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        return initialLabel
    }
    
    private func makeTapGestureRecognizer() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(tapped))
    }
    
    @objc private func tapped() {
        guard let candidate = self.candidate else { return }
        delegate?.candidiateViewTapped(self, candidate: candidate)
    }
}
