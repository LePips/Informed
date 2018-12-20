//
//  User.swift
//  Informed
//
//  Created by Ethan Pippin on 6/8/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import SharedPips

struct User: Codable {
    var email: String
    
    public static var empty = User(email: "ethanpippin@gmail.com")
}
