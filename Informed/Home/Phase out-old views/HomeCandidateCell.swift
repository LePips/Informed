//
//  HomeCandidateCell.swift
//  Informed
//
//  Created by Ethan Pippin on 9/12/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips
import Kingfisher

class HomeCandidateCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat {
        return 70
    }
    
    func configure(with candidate: Candidate) {
        _ = portraitCircle
        
//        if let imageURL = candidate.imageString {
//            let url = URL(string: imageURL)!
//            portraitCircle.kf.setImage(with: url)
//        }
    }
    
    private lazy var portraitCircle: UIImageView = self._protraitCircle()
    private func _protraitCircle() -> UIImageView {
        let portraitCirle = UIImageView.forAutoLayout()
        
        
        
        return portraitCirle
    }
}
