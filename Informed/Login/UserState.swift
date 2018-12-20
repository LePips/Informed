//
//  UserState.swift
//  Informed
//
//  Created by Ethan Pippin on 9/18/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import SharedPips

fileprivate let userDefaultKey = "informed.storedUser"
fileprivate var userStateDefaults = UserDefaults(suiteName: "informed.user")!

enum UserEventChange {
    case loggedIn(User)
    case loggedOut
}

private let sharedCore: Core<UserState> = {
    return Core(state: UserState.emptyState())
}()

struct UserState: State {
    private var storedUser: User? = nil {
        didSet {
            var data: Data? = nil
            if let storedUser = storedUser {
                do {
                    let encoder = JSONEncoder()
                    data = try encoder.encode(storedUser)
                } catch {
                    print("user encoding error: \(error)")
                }
            }
            userStateDefaults.set(data, forKey: userDefaultKey)
        }
    }
    public var user: User? {
        get {
            return storedUser
        }
        set {
            storedUser = newValue
        }
    }
    
    init() {
        guard let data = userStateDefaults.value(forKey: userDefaultKey) as? Data else { return }
        let decoder = JSONDecoder()
        do {
            let user = try decoder.decode(User.self, from: data)
            self.storedUser = user
        } catch {
            print("user decoding error: \(error)")
        }
    }
    
    typealias EventType = UserEventChange
    
    static var core: Core<UserState> {
        return sharedCore
    }
    
    mutating func respond(to event: UserEventChange) {
        switch event {
        case .loggedIn(let user):
            self.user = user
        case .loggedOut:
            self.user = nil
        }
    }
    
    static func emptyState() -> UserState {
        return UserState()
    }
}
