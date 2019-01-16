//
//  AppDelegate.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import SharedPips

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userState: UserState? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        window?.rootViewController = MainViewController()
        FirebaseApp.configure()
        
        Election.getElections()
        Election.getElection(id: 1)
        
        return true
    }
}
