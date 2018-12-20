//
//  LoginErrorHandler.swift
//  Informed
//
//  Created by Ethan Pippin on 9/21/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import FirebaseAuth

struct LoginErrorHandler {
    static func handle(_ error: Error, _ loginUser: LoginUser = ("","")) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            switch errorCode {
            case .userNotFound:
                Auth.auth().createUser(withEmail: loginUser.email, password: loginUser.password) { result, error in
                    if let error = error {
                        LoginErrorHandler.handle(error)
                    } else {
                        let user = User(email: (result?.user.email)!)
                        UserState.core.fire(.loggedIn(user))
                    }
                }
            default:
                print(error.localizedDescription)
            }
        }
    }
}
