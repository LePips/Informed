//
//  PictureCell.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class PictureCell: BasicTableViewCell {
    
    let parallaxFactor: CGFloat = 70
    
    static var neededHeight: CGFloat {
        return 250
    }
    
    func configure(with imageString: String?) {
        _ = picture
        
        if let string = imageString {
            picture.kf.setImage(with: URL(string: string)!)
        }
        
        clipsToBounds = true
    }
    
    private lazy var picture: UIImageView = self._picture()
    private func _picture() -> UIImageView {
        let picture = UIImageView.forAutoLayout()
        
        contentView.addSubview(picture)
        NSLayoutConstraint.activate([
            picture.bottomAnchor ⩵ contentView.bottomAnchor + (2 * parallaxFactor),
            picture.leftAnchor ⩵ contentView.leftAnchor,
            picture.rightAnchor ⩵ contentView.rightAnchor,
            picture.topAnchor ⩵ contentView.topAnchor
            ])
        
        picture.image = UIImage()

        picture.clipsToBounds = true
//        picture.layer.cornerRadius = 12
//        picture.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        return picture
    }
    
    func setBackgroundOffset(offset: CGFloat) {
//        let boundOffset = max(0, min(1, offset))
//        let pixelOffset = (1 - boundOffset) * 2 * parallaxFactor
//        picture.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -pixelOffset)
//        picture.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: pixelOffset)
//
//        UIView.animate(withDuration: 0.1) {
//            self.contentView.layoutIfNeeded()
//        }
    }
}
