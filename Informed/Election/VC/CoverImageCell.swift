//
//  CoverImageCell.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class CoverImageCell: BasicTableViewCell, NeededHeight {
    
    private lazy var coverImageView = self.makeImageView()
    
    override func setupSubviews() {
        embed(coverImageView)
    }
    
    override func setupLayoutConstraints() {
    }
    
    static var neededHeight: CGFloat = 475
    
    func configure(with url: URL) {
        
        coverImageView.kf.setImage(with: url)
        
        clipsToBounds = true
        setGradient()
        self.backgroundColor = .black
    }
    
    private func setGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.8, 1]
        coverImageView.layer.mask = gradient
    }
    
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView.forAutoLayout()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}
