//
//  DividerCell.swift
//  Informed
//
//  Created by Ethan Pippin on 9/26/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class DividerCell: BasicTableViewCell {
    static var neededHeight: CGFloat {
        return 1
    }
    
    func configure() {
        _ = divider
    }
    
    private lazy var divider: UIView = self._divider()
    private func _divider() -> UIView {
        let divider = UIView.forAutoLayout()
        
        contentView.addSubview(divider)
        NSLayoutConstraint.activate([
            divider.rightAnchor ⩵ contentView.rightAnchor - UI.padding,
            divider.leftAnchor ⩵ contentView.leftAnchor + UI.padding,
            divider.heightAnchor ⩵ 1,
            divider.topAnchor ⩵ contentView.topAnchor
            ])
        
        divider.backgroundColor = UIColor(hex: 0x9B9B9B)
        divider.alpha = 0.2
        
        return divider
    }
}
