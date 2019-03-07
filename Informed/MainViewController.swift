//
//  MainViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 6/8/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class MainViewController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [HomeViewController()]
        navigationBar.prefersLargeTitles = true
        makeBarTransparent()
        tintColor(.white)
        changeTitleFontColor(.white)
        changeLargeTitleFontColor(.white)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
