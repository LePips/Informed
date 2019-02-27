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
    
    var announcement: String
    var dateCreated: String
    private var showOnLaunch: Bool
    var active: Bool
    var shouldShowOnLaunch: Bool {
        return showOnLaunch && active
    }
    
    enum CodingKeys: String, CodingKey {
        case announcement
        case dateCreated = "date_created"
        case showOnLaunch = "show_on_launch"
        case active
    }
    
    init(with decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.announcement = try container.decode(for: .announcement)
        self.dateCreated = try container.decode(for: .dateCreated)
        self.showOnLaunch = try container.decode(for: .showOnLaunch)
        self.active = try container.decode(for: .active)
    }
    
    static func getAnnouncements() {
        let url = Strings.URL.baseUrl + "announcements/"
        Internet.GET(url: url) { (response) in
            if let error = response.error {
                print(error)
                return
            }
            if let value = response.value {
                do {
                    let key = value.json["announcements"] as! [JSON]
                    let announcementData = try JSONSerialization.data(withJSONObject: key, options: .prettyPrinted)
                    let announcements = try JSONDecoder().decode([Announcement].self, from: announcementData)
                    AnnouncementState.core.fire(.fetchedAll(announcements))
                } catch {
                    return
                }
            }
        }
    }
    
    func shouldBroadcast() -> Bool {
        return false
    }
}

enum AnnouncementChange {
    case fetchedAll([Announcement])
}

private let sharedCore: Core<AnnouncementState> = {
    return Core(state: AnnouncementState.emptyState())
}()

struct AnnouncementState: State {
    
    var announcements: [Announcement] = []
    
    typealias EventType = AnnouncementChange
    
    static var core: Core<AnnouncementState> {
        return sharedCore
    }
    
    mutating func respond(to event: AnnouncementChange) {
        switch event {
        case .fetchedAll(let announcements):
            self.announcements = announcements
        }
    }
    
    static func emptyState() -> AnnouncementState {
        return AnnouncementState()
    }
}
