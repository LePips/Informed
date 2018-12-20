//
//  OtherCell.swift
//  Informed
//
//  Created by Ethan Pippin on 9/27/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class OtherCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat {
        return 150
    }
    
    func configure() {
        _ = title
        _ = stackView
        
        title.text = "Other"
    }
    
    private lazy var title: UILabel = self.makeTitle()
    private func makeTitle() -> UILabel {
        let title = UILabel.forAutoLayout()
        
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.leftAnchor ⩵ contentView.leftAnchor + UI.padding,
            title.topAnchor ⩵ contentView.topAnchor + 9
            ])
        
        title.setFont(.semibold, size: 21)
        
        return title
    }
    
    private lazy var stackView: UIStackView = self.makeStackView()
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView.forAutoLayout()
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor ⩵ contentView.leftAnchor + UI.padding,
            stackView.topAnchor ⩵ title.bottomAnchor,
            stackView.rightAnchor ⩵ contentView.rightAnchor
            ])
        
        stackView.axis = .vertical
        
        return stackView
    }
    
}
