//
//  InfoCell.swift
//  Informed
//
//  Created by Ethan Pippin on 9/26/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class InfoCell: BasicTableViewCell {
    
    static var neededHeight: CGFloat = 150
    static func heightFor(_ text: String) -> CGFloat {
        let mockLabel = UILabel()
        mockLabel.text = text
        
        if mockLabel.intrinsicContentSize.height > 150 {
            return 150
        } else {
            return mockLabel.bounds.height
        }
    }
    
    var expanded = false
    
    func expand() {
        expanded = true
        InfoCell.neededHeight = 300
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }
    
    func shrink() {
        expanded = false
        InfoCell.neededHeight = 150
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }

    func configure(with info: Info = Info.nothing()) {
        _ = title
        _ = content
        _ = bottomDrawer
        _ = readMoreLabel
        _ = downCarot
        _ = tapGesture
        
        title.text = info.title
        content.text = info.content
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
    
    private lazy var content: UITextView = self.makeContent()
    private func makeContent() -> UITextView {
        let content = UITextView.forAutoLayout()
        
        contentView.addSubview(content)
        NSLayoutConstraint.activate([
            content.rightAnchor ⩵ contentView.rightAnchor - UI.padding,
            content.leftAnchor ⩵ contentView.leftAnchor + UI.padding,
            content.topAnchor ⩵ title.bottomAnchor
            ])
        
        let spacing = NSMutableParagraphStyle()
        spacing.lineSpacing = 19
        content.attributedText = NSAttributedString(string: "", attributes: [.paragraphStyle: spacing])
        
        content.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        content.alpha = 0.56
        content.isEditable = false
        content.isSelectable = false
        content.isScrollEnabled = false
        
        return content
    }
    
    private lazy var bottomDrawer: UIView = makeBottomDrawer()
    private func makeBottomDrawer() -> UIView {
        let drawer = UIView.forAutoLayout()
        
        contentView.addSubview(drawer)
        NSLayoutConstraint.activate([
            drawer.leftAnchor ⩵ contentView.leftAnchor,
            drawer.rightAnchor ⩵ contentView.rightAnchor,
            drawer.bottomAnchor ⩵ contentView.bottomAnchor - 30,
            drawer.heightAnchor ⩵ 50
            ])
        
        drawer.layer.cornerRadius = 8
        
        return drawer
    }
    
    private lazy var readMoreLabel: UILabel = makeReadMoreLabel()
    private func makeReadMoreLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        
        bottomDrawer.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor ⩵ bottomDrawer.leftAnchor + UI.padding,
            label.centerYAnchor ⩵ bottomDrawer.centerYAnchor
            ])
        
        label.setFont(.regular, size: 18)
        label.textColor = UIColor.blue
        label.text = "Read more"
        label.textColor = UIColor(hex: 0x4A90E2)
        
        return label
    }
    
    private lazy var downCarot: UIImageView = self.makeDownCarot()
    private func makeDownCarot() -> UIImageView {
        let carot = UIImageView.forAutoLayout()
        
        bottomDrawer.addSubview(carot)
        NSLayoutConstraint.activate([
            carot.leftAnchor ⩵ readMoreLabel.rightAnchor + 10,
            carot.centerYAnchor ⩵ bottomDrawer.centerYAnchor
            ])
        
        carot.image = UIImage.named("Down Carot").withRenderingMode(.alwaysOriginal)
        
        return carot
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = self.makeTapGesture()
    private func makeTapGesture() -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        bottomDrawer.addGestureRecognizer(tap)
        return tap
    }
    
    @objc private func handleTap() {
        self.bottomDrawer.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.7) {
            self.bottomDrawer.backgroundColor = UIColor.Material.grey100
        }
        UIView.animate(withDuration: 0.5) {
            self.bottomDrawer.backgroundColor = UIColor.white
        }
//        if expanded {
//            shrink()
//        } else {
//            expand()
//        }
    }
}

extension UIView {
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.parentView(of: UITableView.self)
    }
}
