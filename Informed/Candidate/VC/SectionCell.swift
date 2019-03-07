//
//  SectionCell.swift
//  Informed
//
//  Created by Ethan Pippin on 3/5/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class SectionCell: BasicTableViewCell, NeededHeight {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var infoTextView = makeInfoTextView()
    
    func configure(with title: String, text: String) {
        titleLabel.text = title
        infoTextView.text = text
        self.backgroundColor = .black
    }
    
    override func setupSubviews() {
        addSubview(titleLabel)
        addSubview(infoTextView)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor ⩵ topAnchor + Metrics.CellInsets.topPadding,
            titleLabel.leftAnchor ⩵ leftAnchor + Metrics.CellInsets.leftPadding
            ])
        NSLayoutConstraint.activate([
            infoTextView.topAnchor ⩵ titleLabel.bottomAnchor + 6,
            infoTextView.bottomAnchor ⩵ bottomAnchor,
            infoTextView.leftAnchor ⩵ leftAnchor + Metrics.CellInsets.leftPadding,
            infoTextView.rightAnchor ⩵ rightAnchor - Metrics.CellInsets.rightPadding
            ])
    }
    
    static var neededHeight: CGFloat = 100
    static func neededHeight(for text: String) -> CGFloat {
        let base: CGFloat = 52
        let textHeight = text.height(withConstrainedWidth: UIScreen.main.bounds.width - 40, font: UIFont.systemFont(ofSize: 14, weight: .regular))
        return base + textHeight + 15
    }
    
    private func makeTitleLabel() -> UILabel {
        return UILabel.header()
    }
    
    private func makeInfoTextView() -> UITextView {
        let textView = UITextView.forAutoLayout()
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .white
        textView.backgroundColor = .black
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }
}
