//
//  LargeCardCell.swift
//  Informed
//
//  Created by Ethan Pippin on 8/24/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class LargeCardCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat {
        return 250
    }
    
    var election: Election!
    
    func configure(with election: Election) {
        self.election = election
        
        if let feature = ElectionState.core.state.featuredElection {
            self.election = feature
        } else {
            self.election = election
        }
        
        titleLabel.text = self.election.title
        featuredLabel.text = "Featured".uppercased()
        
        _ = holderView
        _ = mainImageView
        _ = titleLabel
        _ = featuredLabel
        
//        if let url = self.election.coverImageUrl {
//            mainImageView.kf.setImage(with: URL(string: url)!)
//        }
        
        selectionStyle = .none
    }
    
    var holderBounds: CGRect {
        return holderView.frame
    }
    
    private lazy var holderView: UIView = self._holderView()
    private func _holderView() -> UIView {
        let holderView = UIView.forAutoLayout()
        
        contentView.addSubview(holderView)
        NSLayoutConstraint.activate([
            holderView.leftAnchor ⩵ contentView.leftAnchor + 10,
            holderView.rightAnchor ⩵ contentView.rightAnchor - 10,
            holderView.topAnchor ⩵ contentView.topAnchor + 10,
            holderView.bottomAnchor ⩵ contentView.bottomAnchor - 5
            ])
        
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        holderView.backgroundColor = UIColor.Informed.Secondary.secondary
        
        return holderView
    }
    
    private lazy var mainImageView: UIImageView = self._mainImageView()
    private func _mainImageView() -> UIImageView {
        let mainImageView = UIImageView.forAutoLayout()
        
        holderView.embed(mainImageView)
        
        return mainImageView
    }
    
    private lazy var titleLabel: UILabel = self._titleLabel()
    private func _titleLabel() -> UILabel {
        let titleLabel = UILabel.forAutoLayout()
        
        holderView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor ⩵ holderView.centerXAnchor,
            titleLabel.topAnchor ⩵ holderView.topAnchor,
            titleLabel.bottomAnchor ⩵ holderView.bottomAnchor,
            titleLabel.widthAnchor ⩵ holderView.widthAnchor × 0.8
            ])
        
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.baselineAdjustment = .alignCenters
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        return titleLabel
    }
    
    private lazy var featuredLabel: UILabel = self.makeFeaturedLabel()
    private func makeFeaturedLabel() -> UILabel {
        let featuredLabel = UILabel.forAutoLayout()
        
        holderView.addSubview(featuredLabel)
        NSLayoutConstraint.activate([
            featuredLabel.centerXAnchor ⩵ holderView.centerXAnchor,
            featuredLabel.topAnchor ⩵ holderView.topAnchor + 15,
            featuredLabel.widthAnchor ⩵ holderView.widthAnchor × 0.8
            ])
        
        featuredLabel.textAlignment = .center
        featuredLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        featuredLabel.textColor = .white
        
        return featuredLabel
    }
    
}
