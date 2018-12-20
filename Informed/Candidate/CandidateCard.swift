//
//  CandidateCard.swift
//  Informed
//
//  Created by Ethan Pippin on 6/8/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class CandidateCard: UIView {
    
    var candidate: Candidate!
    
    func configure(with candidate: Candidate) {
        self.candidate = candidate
        _ = imageView
    }
    
    private lazy var imageView: UIImageView = self._imageView()
    private func _imageView() -> UIImageView {
        let imageView = UIImageView.forAutoLayout()
        
        embed(imageView)
        
        imageView.image = UIImage(named: "ethan_profile")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }
    
}
