//
//  LargeTitleHeader.swift
//  Informed
//
//  Created by Ethan Pippin on 8/31/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class LargeTitleHeader: BasicHeaderFooterView {
    
    static var neededHeight: CGFloat {
        return 60
    }
    
    func configure(with title: String) {
        largeTitle.text = title
        
        contentView.backgroundColor = .white
        
        _ = largeTitle
    }
    
    private lazy var largeTitle: UILabel = self._largeTitle()
    private func _largeTitle() -> UILabel {
        let title = UILabel.forAutoLayout()
        
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerYAnchor ⩵ contentView.centerYAnchor,
            title.leftAnchor ⩵ contentView.leftAnchor + 30
            ])
        
        title.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        title.text = ""
        
        return title
    }
}
