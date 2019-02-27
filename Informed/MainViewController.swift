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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AnnouncementState.core.addSubscriber(subscriber: self, update: MainViewController.update)
        
    }
}

extension MainViewController: Subscriber {
    func update(with state: AnnouncementState) {
        if !state.announcements.isEmpty {
            let announcement = state.announcements[0]
            let vc = AnnouncementViewController(announcement: announcement)
            self.present(vc, animated: true)
        }
    }
}
