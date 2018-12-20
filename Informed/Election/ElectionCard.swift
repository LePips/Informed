//
//  ElectionCard.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

struct ElectionCardFactory {
    
    static func create(_ amount: Int, open: @escaping () -> Void) -> [ElectionCard] {
        var cards: [ElectionCard] = []
        
        for _ in 0..<amount {
            let card = ElectionCard()
            let election = Election.single()
            card.configure(with: election, open: open)
            card.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
            cards.append(card)
        }
        
        return cards
    }
    
}

class ElectionCard: CategoryView {
    
    var election: Election!
    var open: (() -> Void)!
    
    func configure(with election: Election, open: @escaping () -> Void) {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
        
        self.election = election
        self.open = open
        
        self.backgroundColor = UIColor.TEEM.strawberry
        _ = picture
        _ = tapGesture
    }
    
    private lazy var label: UILabel = self._label()
    private func _label() -> UILabel {
        let label = UILabel.forAutoLayout()
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.bottomAnchor ⩵ self.bottomAnchor - 5,
            label.leftAnchor ⩵ self.leftAnchor + 5
            ])
        
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }
    
    private lazy var picture: UIImageView = self._picture()
    private func _picture() -> UIImageView {
        let picture = UIImageView.forAutoLayout()
        
        embed(picture)
        picture.image = UIImage()
        
        return picture
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = self._tapGesture()
    private func _tapGesture() -> UITapGestureRecognizer {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.addGestureRecognizer(gesture)
        return gesture
    }
    
    @objc override func tapped() {
        open()
    }
}
