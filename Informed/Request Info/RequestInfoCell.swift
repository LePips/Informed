//
//  RequestInfoCell.swift
//  Informed
//
//  Created by Ethan Pippin on 9/27/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class RequestInfoCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat {
        return 70
    }
    
    func configure() {
        _ = icon
        _ = title
        
        title.text = "Request Info"
    }
    
    private lazy var icon: UIImageView = self.makeIcon()
    private func makeIcon() -> UIImageView {
        let icon = UIImageView.forAutoLayout()
        
        contentView.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.leftAnchor ⩵ contentView.leftAnchor + 29,
            icon.centerYAnchor ⩵ contentView.centerYAnchor,
            ])
        
        icon.image = UIImage.named("Request Info").withRenderingMode(.alwaysOriginal)
        
        return icon
    }
    
    private lazy var title: UILabel = self.makeTitle()
    private func makeTitle() -> UILabel {
        let title = UILabel.forAutoLayout()
        
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.leftAnchor ⩵ icon.rightAnchor + 10,
            title.centerYAnchor ⩵ contentView.centerYAnchor
            ])
        
        title.setFont(.medium, size: 21)
        title.textColor = UIColor(hex: 0x4A90E2)
        
        return title
    }
}
