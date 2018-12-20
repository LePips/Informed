//
//  ProfileViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 6/8/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    let user: User!
    
    private lazy var logoutButton: UIButton = self._logoutButton()
    private func _logoutButton() -> UIButton {
        let button = UIButton.forAutoLayout()
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor ⩵ view.centerXAnchor,
            button.heightAnchor ⩵ 48,
            button.widthAnchor ⩵ view.widthAnchor × 0.8,
            button.bottomAnchor ⩵ view.bottomAnchor - 50
            ])
        
        button.layer.cornerRadius = 8
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = UIColor.Material.red100
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        return button
    }
    
    @objc private func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserState.core.fire(.loggedOut)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    private lazy var darkModeSwitch: UISwitch = self.makeDarkModeSwitch()
    private func makeDarkModeSwitch() -> UISwitch {
        let darkModeSwitch = UISwitch.forAutoLayout()
        
        view.addSubview(darkModeSwitch)
        NSLayoutConstraint.activate([
            darkModeSwitch.leftAnchor ⩵ logoutButton.leftAnchor,
            darkModeSwitch.bottomAnchor ⩵ logoutButton.topAnchor - 100
            ])
        
        darkModeSwitch.addTarget(self, action: #selector(triggerDarkMode(_:)), for: .valueChanged)
        
        return darkModeSwitch
    }
    
    @objc private func triggerDarkMode(_ sender: UISwitch) {
        UIState.core.fire(.uiChanged)
    }
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = UserState.core.state.user?.email
        darkModeSwitch.isOn = UIState.core.state.darkModeOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = logoutButton
        _ = darkModeSwitch
        
        UIState.core.addSubscriber(subscriber: self, update: ProfileViewController.update)
        
        view.backgroundColor = Color.Informed.Primary.primary
    }
}

extension ProfileViewController: Subscriber {
    func update(with state: UIState) {
        if state.darkModeOn {
            view.backgroundColor = UI.Darkmode.base
        } else {
            view.backgroundColor = UI.Lightmode.base
        }
    }
}
