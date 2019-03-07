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

class CandidateCarouselCell: BasicTableViewCell, NeededHeight {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var candidateCarousel = makeCandidateCarousel()
    
    func configure(with ids: [Int], delegate: CandidateCourselViewDelegate) {
        Candidate.getCandidates(ids) { (candidates) in
            self.configureViewsWith(candidates, delegate: delegate)
        }
        titleLabel.text = "Candidates"
    }
    
    private func configureViewsWith(_ candidates: [Candidate], delegate: CandidateCourselViewDelegate) {
        DispatchQueue.main.sync {
            var views: [UIView] = []
            for candidate in candidates {
                let view = CandidateCarouselView()
                view.configure(with: candidate, delegate: delegate)
                views.append(view)
            }
            candidateCarousel.configure(with: views)
        }
    }
    
    override func setupSubviews() {
        addSubview(titleLabel)
        addSubview(candidateCarousel)
        backgroundColor = .black
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor ⩵ topAnchor + Metrics.CellInsets.topPadding,
            titleLabel.leftAnchor ⩵ leftAnchor + Metrics.CellInsets.leftPadding
            ])
        NSLayoutConstraint.activate([
            candidateCarousel.topAnchor ⩵ titleLabel.bottomAnchor + 6,
            candidateCarousel.bottomAnchor ⩵ bottomAnchor,
            candidateCarousel.leftAnchor ⩵ leftAnchor,
            candidateCarousel.rightAnchor ⩵ rightAnchor
            ])
    }
    
    static var neededHeight: CGFloat = 200
    
    private func makeTitleLabel() -> UILabel {
        return UILabel.header()
    }
    
    private func makeCandidateCarousel() -> CategoryScrollView {
        return CategoryScrollView.forAutoLayout()
    }
}

class CandidateCarouselView: BasicView {
    
    private lazy var initialLabel = makeInitialLabel()
    private lazy var tapGestureRecognizer = makeTapGestureRecognizer()
    private lazy var imageView = makeImageView()
    private var delegate: CandidateCourselViewDelegate?
    private var candidate: Candidate?
    
    func configure(with candidate: Candidate, delegate: CandidateCourselViewDelegate) {
        self.delegate = delegate
        self.candidate = candidate
        
        let first = candidate.first.first
        let last = candidate.last.first
        let initials = String(describing: first!).capitalized + String(describing: last!).capitalized
        initialLabel.text = initials
        
        backgroundColor = UIColor.Informed.darkGrey
        layer.cornerRadius = 8
        
//        imageView.kf.setImage(with: candidate.coverImage)
    }
    
    override func setupSubviews() {
        addSubview(initialLabel)
        embed(imageView)
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            initialLabel.centerXAnchor ⩵ centerXAnchor,
            initialLabel.centerYAnchor ⩵ centerYAnchor
            ])
    }
    
    private func makeInitialLabel() -> UILabel {
        let initialLabel = UILabel.forAutoLayout()
        initialLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        initialLabel.textColor = .white
        return initialLabel
    }
    
    private func makeTapGestureRecognizer() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(tapped))
    }
    
    @objc private func tapped() {
        guard let candidate = self.candidate else { return }
        delegate?.candidiateViewTapped(self, candidate: candidate)
    }
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView.forAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }
}
