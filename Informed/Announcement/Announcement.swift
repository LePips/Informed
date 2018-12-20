//
//  Announcement.swift
//  Informed
//
//  Created by Ethan Pippin on 9/19/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import SharedPips

fileprivate let announcementDefaultKey = "informed.announcement.version"
fileprivate let announcementStateDefaults = UserDefaults(suiteName: "informed.announcements")

struct Announcement: Codable {
    
    var broadcast: Bool
    var message: String
    var version: Int
    
    static func getAnnouncement() {
        Internet.GET(url: Firenet.announcements, source: .firebase) { response in
            guard let data = response.value?.data else { return }
            
            do {
                let announcement = try JSONDecoder().decode(Announcement.self, from: data)
                AnnouncementState.core.fire(.fetched(announcement))
            } catch {
                print("error with announcement parsing")
            }
        }
    }
    
    func shouldBroadcast() -> Bool {
        guard let value = AnnouncementState.core.state.announcement?.version else { return false }
        return value <= 2
    }
}

enum AnnouncementChange {
    case fetched(Announcement)
}

private let sharedCore: Core<AnnouncementState> = {
    return Core(state: AnnouncementState.emptyState())
}()

struct AnnouncementState: State {
    
    var announcement: Announcement? = nil {
        didSet {
            var data: Data? = nil
            if let version = announcement?.version {
                do {
                    let encoder = JSONEncoder()
                    data = try encoder.encode(version)
                } catch {
                    print("announcement version encoding error: \(error)")
                }
            }
            announcementStateDefaults?.set(data, forKey: announcementDefaultKey)
        }
    }
    
    typealias EventType = AnnouncementChange
    
    static var core: Core<AnnouncementState> {
        return sharedCore
    }
    
    mutating func respond(to event: AnnouncementChange) {
        switch event {
        case .fetched(let announcement):
            self.announcement = announcement
        }
    }
    
    static func emptyState() -> AnnouncementState {
        return AnnouncementState(announcement: nil)
    }
}
