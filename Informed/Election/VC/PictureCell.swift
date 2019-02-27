//
//  PictureCell.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class PictureCell: BasicTableViewCell, NeededHeight {
    
    static var neededHeight: CGFloat = 475
    
    func configure(with imageString: String?) {
        _ = picture
        
        if let string = imageString {
            picture.kf.setImage(with: URL(string: string)!)
        }
        
        clipsToBounds = true
        setGradient()
        self.backgroundColor = .black
    }
    
    private func setGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.8, 1]
        picture.layer.mask = gradient
    }
    
    private lazy var picture: UIImageView = self._picture()
    private func _picture() -> UIImageView {
        let picture = UIImageView.forAutoLayout()
        
        contentView.addSubview(picture)
        NSLayoutConstraint.activate([
            picture.bottomAnchor ⩵ contentView.bottomAnchor,
            picture.leftAnchor ⩵ contentView.leftAnchor,
            picture.rightAnchor ⩵ contentView.rightAnchor,
            picture.topAnchor ⩵ contentView.topAnchor
            ])
        
        picture.image = UIImage()

        picture.clipsToBounds = true
        picture.contentMode = .scaleAspectFill
        
        return picture
    }
}
