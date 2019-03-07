//
//  UI.swift
//  Informed
//
//  Created by Ethan Pippin on 10/18/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

fileprivate let darkModeDefaultsKey = "informed.darkMode"
fileprivate var darkModeDefaults = UserDefaults(suiteName: "informed.darkMode")!

protocol Theme: Codable {
    static var base: UIColor { get }
}

struct Metrics {
    
    struct CellInsets {
        static let topPadding: CGFloat = 20
        static let leftPadding: CGFloat = 20
        static let rightPadding: CGFloat = 20
    }
    
}

struct UI {
    
    static let padding: CGFloat = 15
    
    struct Darkmode: Theme {
        static var base: UIColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    struct Lightmode: Theme {
        static var base: UIColor = .white
    }
}

enum UIStateChange {
    case uiChanged
}

struct UIState: State {
    
    var darkModeOn = false
    
    init() {
        guard let data = darkModeDefaults.value(forKey: darkModeDefaultsKey) as? Data else { return }
        let decoder = JSONDecoder()
        do {
            let isDarkModeOn = try decoder.decode(Bool.self, from: data)
            darkModeOn = isDarkModeOn
        } catch {
            print("theme decoding error: \(error)")
        }
    }
    
    typealias EventType = UIStateChange
    
    static var core: Core<UIState> {
        return sharedCore
    }
    
    mutating func respond(to event: UIStateChange) {
        switch event {
        case .uiChanged:
            darkModeOn = !darkModeOn
        }
    }
}

private let sharedCore: Core<UIState> = {
    return Core(state: UIState())
}()
