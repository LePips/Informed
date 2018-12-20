//
//  AnnouncementViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 9/19/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import SharedPips

class AnnouncementViewController: UIViewController {
    
    private lazy var messageLabel: UILabel = self._message()
    private func _message() -> UILabel {
        let message = UILabel.forAutoLayout()
        
        view.addSubview(message)
        NSLayoutConstraint.activate([
            message.centerXAnchor ⩵ view.centerXAnchor,
            message.centerYAnchor ⩵ view.centerYAnchor,
            message.widthAnchor ⩵ view.widthAnchor × 0.6
            ])
        
        message.lineBreakMode = .byWordWrapping
        message.numberOfLines = 0
        message.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        return message
    }
    
    private lazy var dismissButton: UIButton = self._dismissButton()
    private func _dismissButton() -> UIButton {
        let button = UIButton.forAutoLayout()
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor ⩵ view.centerXAnchor,
            button.heightAnchor ⩵ 48,
            button.widthAnchor ⩵ view.widthAnchor × 0.8,
            button.bottomAnchor ⩵ view.bottomAnchor - 50
            ])
        
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.backgroundColor = UIColor.Material.red100
        button.layer.cornerRadius = 8
        
        return button
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}

extension AnnouncementViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = messageLabel
        _ = dismissButton
        
        AnnouncementState.core.addSubscriber(subscriber: self, update: AnnouncementViewController.update)
        
        view.backgroundColor = UIColor.Material.amber100
        
    }
}

extension AnnouncementViewController: Subscriber {
    func update(with state: AnnouncementState) {
        messageLabel.text = state.announcement?.message
    }
}
