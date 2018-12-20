//
//  BaseRequestInfoViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 10/19/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class BaseRequestInfoViewController: UIViewController {
    
    var questionView: UIView
    
    init() {
        self.questionView = UIView()
        super.init(nibName: nil, bundle: nil)
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Request Info"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    }
    
}
