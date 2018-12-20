//
//  SideSheetDrawerView.swift
//  Informed
//
//  Created by Ethan Pippin on 11/18/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

protocol SignInDelegate: class {
    func handleUserState()
}

class SideSheetDrawerView: BasicView {
    
    private lazy var titleLabel: UILabel = makeTitleLabel()
    private lazy var subtitleLabel: UILabel = makeSubtitleLabel()
    private lazy var actionView: UIView = makeActionView()
    private var delegate: SignInDelegate?  = nil
    
    func configure(with title: String, subtitle: String, titleColor: Color, delegate: SignInDelegate) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        titleLabel.textColor = titleColor
        self.delegate = delegate
    }
    
    override func setupSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(actionView)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor ⩵ leftAnchor + 15,
            titleLabel.bottomAnchor ⩵ bottomAnchor - 15
            ])
        NSLayoutConstraint.activate([
            subtitleLabel.leftAnchor ⩵ leftAnchor + 15,
            subtitleLabel.bottomAnchor ⩵ titleLabel.topAnchor - 5
            ])
        NSLayoutConstraint.activate([
            actionView.leftAnchor ⩵ leftAnchor,
            actionView.rightAnchor ⩵ rightAnchor,
            actionView.bottomAnchor ⩵ bottomAnchor,
            actionView.topAnchor ⩵ subtitleLabel.bottomAnchor
            ])
    }
    
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel.forAutoLayout()
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        return titleLabel
    }
    
    private func makeSubtitleLabel() -> UILabel {
        let subtitleLabel = UILabel.forAutoLayout()
        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .gray
        return subtitleLabel
    }
    
    private func makeActionView() -> UIView {
        let actionView = UIView.forAutoLayout()
        let tapppedRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        actionView.addGestureRecognizer(tapppedRecognizer)
        return actionView
    }
    
    @objc private func handleTap() {
        delegate?.handleUserState()
    }
}
