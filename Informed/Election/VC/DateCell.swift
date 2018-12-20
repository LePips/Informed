//
//  DateCell.swift
//  Informed
//
//  Created by Ethan Pippin on 9/26/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class DateCell: BasicTableViewCell {
    static var neededHeight: CGFloat {
        return 63
    }
    
    func configure() {
        _ = icon
        _ = dateLabel
        
        dateLabel.text = "November 3, 2020"
    }
    
    private lazy var icon: UIImageView = self._icon()
    private func _icon() -> UIImageView {
        let icon = UIImageView.forAutoLayout()
        
        contentView.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.leftAnchor ⩵ contentView.leftAnchor + UI.padding,
            icon.heightAnchor ⩵ 32,
            icon.widthAnchor ⩵ 30,
            icon.topAnchor ⩵ contentView.topAnchor + 15
            ])
        
        icon.image = UIImage.named("Calendar").withRenderingMode(.alwaysOriginal)
        
        return icon
    }
    
    private lazy var dateLabel: UILabel = self.makeDateLabel()
    private func makeDateLabel() -> UILabel {
        let dateLabel = UILabel.forAutoLayout()
        
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor ⩵ icon.rightAnchor + 10,
            dateLabel.topAnchor ⩵ contentView.topAnchor + 20
            ])
        
        dateLabel.setFont(.semibold, size: 20)
        dateLabel.textColor = .black
        
        return dateLabel
    }
}
