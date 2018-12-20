//
//  RequestInfoViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 10/2/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

// MARK: -
// MARK: init
extension RequestInfoViewController {
    convenience init(election: Election) {
        self.init(election: election, isGeneral: false)
    }
    
    convenience init() {
        self.init(election: nil, isGeneral: true)
    }
}

class RequestInfoViewController: UIViewController {
    
    let election: Election?
    let isGeneral: Bool
    
    init(election: Election?, isGeneral: Bool) {
        self.election = election
        self.isGeneral = isGeneral
        super.init(nibName: nil, bundle: nil)
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Request Info"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.Material.grey100
    }
}
