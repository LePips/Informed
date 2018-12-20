//
//  LoginDelegates.swift
//  Informed
//
//  Created by Ethan Pippin on 9/21/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import FirebaseAuth

class EmailTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private(set) var email = ""
    
    var passwordTextField: UITextField? = nil
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let input = textField.text else { return }
        email = input
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.returnKeyType = .next
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text == "ep" {
            textField.text = "ethanpippin2343@gmail.com"
            passwordTextField?.text = "starcraft2"
        }
        
        textField.resignFirstResponder()
        passwordTextField?.becomeFirstResponder()
        return true
    }
}

class PasswordTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private(set) var password = ""
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let input = textField.text else { return }
        password = input
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.returnKeyType = .done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
