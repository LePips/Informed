//
//  AboutViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 11/18/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class AboutViewController: BasicViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "About"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        
    }
    
    override func setupLayoutConstraints() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.Informed.Primary.primary
    }
}
