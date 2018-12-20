//
//  LoginViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 9/17/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips
import FirebaseAuth

typealias LoginUser = (email: String, password: String)

class LoginViewController: UIViewController {
    
    var initialState: LoginState = .initial
    private var emailDelegate = EmailTextFieldDelegate()
    private var passwordDelegate = PasswordTextFieldDelegate()
    private var loginUser: LoginUser {
        return (email: emailDelegate.email, password: passwordDelegate.password)
    }
    
    private lazy var emailTextField: UITextField = self._emailTextField()
    private func _emailTextField() -> UITextField {
        let textField = UITextField.forAutoLayout()
        
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerXAnchor ⩵ view.centerXAnchor,
            textField.bottomAnchor ⩵ view.centerYAnchor - 10,
            textField.heightAnchor ⩵ 48,
            textField.widthAnchor ⩵ view.widthAnchor × 0.8,
            ])
        
        textField.layer.cornerRadius = 8
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.delegate = emailDelegate
        
        return textField
    }
    
    private lazy var passwordTextField: UITextField = self._passwordTextField()
    private func _passwordTextField() -> UITextField {
        let textField = UITextField.forAutoLayout()
        
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerXAnchor ⩵ view.centerXAnchor,
            textField.topAnchor ⩵ view.centerYAnchor + 10,
            textField.heightAnchor ⩵ 48,
            textField.widthAnchor ⩵ view.widthAnchor × 0.8,
            ])
        
        textField.layer.cornerRadius = 8
        textField.placeholder = "Password"
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.delegate = passwordDelegate
        
        return textField
    }
    
    private lazy var loginButton: UIButton = self._loginButton()
    private func _loginButton() -> UIButton {
        let button = UIButton.forAutoLayout()
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor ⩵ view.centerXAnchor,
            button.heightAnchor ⩵ 48,
            button.widthAnchor ⩵ view.widthAnchor × 0.8,
            button.bottomAnchor ⩵ view.bottomAnchor - 50
            ])
        
        button.layer.cornerRadius = 8
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.Material.blue100
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        return button
    }
    
    private lazy var loadingLabel: UILabel = self._loadingLabel()
    private func _loadingLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor ⩵ loginButton.centerXAnchor,
            label.centerYAnchor ⩵ loginButton.centerYAnchor,
            ])
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        
        return label
    }
    
    @objc private func login() {
        set(state: .loggingIn)
        
        Auth.auth().signIn(withEmail: emailDelegate.email, password: passwordDelegate.password) { result, error in
            if let error = error {
                self.set(state: .failure)
                LoginErrorHandler.handle(error, self.loginUser)
            } else {
                let user = User(email: (result?.user.email)!)
                UserState.core.fire(.loggedIn(user))
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailDelegate.passwordTextField = passwordTextField
        
        _ = loginButton
        _ = loadingLabel
        _ = emailTextField
        _ = passwordTextField
        loadingLabel.alpha = 0.0
        
        view.backgroundColor = Color.Informed.Primary.primary
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension LoginViewController: Synchronous {
    
    typealias EventState = LoginState
    
    enum LoginState: SynchronousState {
        case initial
        case loggingIn
        case failure
        case creatingUser
        
        var pauseDuration: TimeInterval {
            switch self {
            case .loggingIn:
                return 3.0
            case .failure:
                return 3.0
            case .creatingUser:
                return 2.0
            default:
                return 0
            }
        }
    }
    
    func synchronousSet(_ state: LoginViewController.LoginState) {
        switch state {
        case .initial:
            loginButton.alpha = 1.0
            loadingLabel.alpha = 0.0
            loadingLabel.text = ""
        case .loggingIn:
            loginButton.alpha = 0.0
            loadingLabel.alpha = 1.0
            loadingLabel.text = "Logging in"
        case .failure:
            loginButton.alpha = 0.0
            loadingLabel.alpha = 1.0
            loadingLabel.text = "Error"
        case .creatingUser:
            loginButton.alpha = 0.0
            loadingLabel.alpha = 1.0
            loadingLabel.text = "Creating User"
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.returnKeyType = .done
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.returnKeyType = .done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
