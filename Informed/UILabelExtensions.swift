//
//  UILabelExtensions.swift
//  Informed
//
//  Created by Ethan Pippin on 2/28/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

extension UILabel {
    static func header() -> UILabel {
        let label = UILabel.forAutoLayout()
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        return label
    }
}
