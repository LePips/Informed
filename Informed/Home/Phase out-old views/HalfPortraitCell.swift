//
//  HalfPortraitCell.swift
//  Informed
//
//  Created by Ethan Pippin on 9/14/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class HalfPortraitCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat {
        return 175
    }
    
    var firstCandidate: Candidate!
    var secondCandidate: Candidate!
    var vc: UIViewController!
    
    func configure(with candidates: [Candidate], vc: UIViewController) {
        self.firstCandidate = candidates.first
        self.secondCandidate = candidates[1]
        self.vc = vc
        
        let firstPortrait = URL(string: firstCandidate.imageString!)!
        firstImageView.kf.setImage(with: firstPortrait)
        
        let secondPortrait = URL(string: secondCandidate.imageString!)!
        secondImageView.kf.setImage(with: secondPortrait)
        
        _ = firstImageHolderView
        _ = firstImageView
        _ = openFirstCandidate
        
        selectionStyle = .none
    }
    
    private lazy var firstImageHolderView: UIView = self._firstImageHolderView()
    private func _firstImageHolderView() -> UIView {
        let holderView = UIView.forAutoLayout()
        
        let bounds: CGFloat = (contentView.bounds.width / 2) - 40
        contentView.addSubview(holderView)
        NSLayoutConstraint.activate([
            holderView.centerYAnchor ⩵ contentView.centerYAnchor,
            holderView.leftAnchor ⩵ contentView.leftAnchor + 20,
            holderView.heightAnchor ⩵ bounds,
            holderView.widthAnchor ⩵ bounds
            ])
        
        holderView.layer.cornerRadius = bounds / 2
        holderView.clipsToBounds = true
        holderView.layer.borderWidth = 3
        holderView.layer.borderColor = UIColor.gray.cgColor
        
        return holderView
    }
    
    private lazy var firstImageView: UIImageView = self._firstPortraitHolderView()
    private func _firstPortraitHolderView() -> UIImageView {
        let holderView = UIImageView.forAutoLayout()
        
        firstImageHolderView.embed(holderView)
        
        return holderView
    }
    
    private lazy var secondImageView: UIImageView = self._secondImageView()
    private func _secondImageView() -> UIImageView {
        let holderView = UIImageView.forAutoLayout()
        
        let bounds: CGFloat = (contentView.bounds.width / 2) - 40
        contentView.addSubview(holderView)
        NSLayoutConstraint.activate([
            holderView.centerYAnchor ⩵ contentView.centerYAnchor,
            holderView.rightAnchor ⩵ contentView.rightAnchor - 20,
            holderView.heightAnchor ⩵ bounds,
            holderView.widthAnchor ⩵ bounds
            ])
        
        holderView.layer.cornerRadius = bounds / 2
        holderView.clipsToBounds = true
        holderView.layer.borderWidth = 3
        holderView.layer.borderColor = UIColor.gray.cgColor
        
        return holderView
    }
    
    private lazy var openFirstCandidate: UITapGestureRecognizer = self._openFirstCandidate()
    private func _openFirstCandidate() -> UITapGestureRecognizer {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedFirstCandidate))
        firstImageHolderView.addGestureRecognizer(gesture)
        return gesture
    }
    
    @objc private func tappedFirstCandidate() {
        let candidateVC = CandidateViewController(with: firstCandidate)
        vc.present(candidateVC, animated: true)
    }
}
