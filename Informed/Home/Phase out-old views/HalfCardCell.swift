//
//  HalfCardCell.swift
//  Informed
//
//  Created by Ethan Pippin on 8/25/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class HalfCardCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat {
        return 250
    }
    
    var firstElection: Election!
    var secondElection: Election!
    var vc: UIViewController!
    
    func configure(with elections: [Election], vc: UIViewController) {
        self.firstElection = elections[0]
        self.secondElection = elections[1]
        self.vc = vc
        
        firstCardHolderView.backgroundColor = Color.Material.purple100
        secondCardHolderView.backgroundColor = Color.Material.green100
        
        _ = firstCardHolderView
        _ = secondCardHolderView
        _ = openFirstElection
        _ = openSecondElection
        
        selectionStyle = .none
    }
    
    private lazy var firstCardHolderView: UIView = self._firstCardHolderView()
    private func _firstCardHolderView() -> UIView {
        let firstCardHolderView = UIView.forAutoLayout()
        
        contentView.addSubview(firstCardHolderView)
        NSLayoutConstraint.activate([
            firstCardHolderView.leftAnchor ⩵ contentView.leftAnchor + 10,
            firstCardHolderView.rightAnchor ⩵ contentView.centerXAnchor - 5,
            firstCardHolderView.topAnchor ⩵ contentView.topAnchor + 5,
            firstCardHolderView.bottomAnchor ⩵ contentView.bottomAnchor - 10
            ])
        
        firstCardHolderView.layer.cornerRadius = 5
        firstCardHolderView.clipsToBounds = true
        
        return firstCardHolderView
    }
    
    private lazy var secondCardHolderView: UIView = self._secondCardHolderView()
    private func _secondCardHolderView() -> UIView {
        let secondCardHolderView = UIView.forAutoLayout()
        
        contentView.addSubview(secondCardHolderView)
        NSLayoutConstraint.activate([
            secondCardHolderView.leftAnchor ⩵ contentView.centerXAnchor + 5,
            secondCardHolderView.rightAnchor ⩵ contentView.rightAnchor - 10,
            secondCardHolderView.topAnchor ⩵ contentView.topAnchor + 5,
            secondCardHolderView.bottomAnchor ⩵ contentView.bottomAnchor - 10
            ])
        
        secondCardHolderView.layer.cornerRadius = 5
        secondCardHolderView.clipsToBounds = true
        
        return secondCardHolderView
    }
    
    private lazy var openFirstElection: UITapGestureRecognizer = self._openFirstElection()
    private func _openFirstElection() -> UITapGestureRecognizer {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedFirstElection))
        firstCardHolderView.addGestureRecognizer(gesture)
        return gesture
    }
    
    @objc private func tappedFirstElection() {
        let electionVC = ElectionViewController(with: firstElection)
        vc.present(electionVC, animated: true)
    }
    
    private lazy var openSecondElection: UITapGestureRecognizer = self._openSecondElection()
    private func _openSecondElection() -> UITapGestureRecognizer {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedSecondElection))
        secondCardHolderView.addGestureRecognizer(gesture)
        return gesture
    }
    
    @objc private func tappedSecondElection() {
        let electionVC = ElectionViewController(with: secondElection)
        vc.present(electionVC, animated: true)
    }
}
