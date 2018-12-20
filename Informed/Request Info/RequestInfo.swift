//
//  RequestInfo.swift
//  Informed
//
//  Created by Ethan Pippin on 10/19/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit

struct RequestInfo {
    
    static func main() -> UIViewController {
        return RequestInfoViewController()
    }
    
    static func election(_ election: Election) -> UIViewController {
        return RequestInfoViewController(election: election)
    }
    
}
