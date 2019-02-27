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
    
    private lazy var icon: UIImageView = self.makeIcon()
    private lazy var dateLabel: UILabel = self.makeDateLabel()
    private var date: Date = Date()
    
    override func setupSubviews() {
        contentView.addSubview(icon)
        contentView.addSubview(dateLabel)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            icon.leftAnchor ⩵ contentView.leftAnchor + UI.padding,
            icon.heightAnchor ⩵ 32,
            icon.widthAnchor ⩵ 30,
            icon.topAnchor ⩵ contentView.topAnchor + 15
            ])
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor ⩵ icon.rightAnchor + 10,
            dateLabel.topAnchor ⩵ contentView.topAnchor + 20
            ])
    }
    
    static var neededHeight: CGFloat {
        return 63
    }
    
    func configure(with dateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            self.date = date
        }
        
        dateLabel.text = dateString
    }
    
    private func makeIcon() -> UIImageView {
        let icon = UIImageView.forAutoLayout()
        icon.image = UIImage.named("Calendar").withRenderingMode(.alwaysOriginal)
        return icon
    }
    
    private func makeDateLabel() -> UILabel {
        let dateLabel = UILabel.forAutoLayout()
        dateLabel.setFont(.semibold, size: 20)
        dateLabel.textColor = .black
        return dateLabel
    }
}
