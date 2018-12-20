//
//  Election.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

enum ElectionCategory: String, Codable {
    case national
    case state
}

struct Election: Codable {
    let title: String
    let category: ElectionCategory
    let coverImageUrl: String?
    let dateOfElection: Date?
    let electionID: Int
    let info: [String: Info]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case category
        case coverImageUrl
        case dateOfElection
        case electionID = "id"
        case info
    }
    
    init(with decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(for: .title)
        self.category = try container.decode(for: .category)
        self.coverImageUrl = try container.decode(for: .coverImageUrl)
        self.dateOfElection = try container.decode(for: .dateOfElection)
        self.electionID = try container.decode(for: .electionID)
        self.info = try container.decode(for: .info)
    }
    
    init(_ title: String, _ category: ElectionCategory, _ id: Int, _ coverImageUrl: String? = nil, _ date: Date? = nil) {
        self.title = title
        self.category = category
        self.coverImageUrl = coverImageUrl
        self.dateOfElection = date
        self.electionID = id
        self.info = [:]
    }
    
    static func single() -> Election {
        let election = Election("Roman Caesar", .national, -1)
        return election
    }
    
    static func getElections() {
        Internet.GET(url: Firenet.elections, source: .firebase) { response in
            
            guard let data = response.value?.data else { return }

            do {
                let elections = try JSONDecoder().decode([Election].self, from: data)
                ElectionState.core.fire(.fetchedAll(elections))
            } catch {
                print("error with election json parsing")
            }
        }
    }
    
    static func getFeaturedElection() {
        Internet.GET(url: Firenet.featuredElection) { response in
            
            guard let data = response.value?.data else { return }
            
            do {
                let election = try JSONDecoder().decode(Election.self, from: data)
                ElectionState.core.fire(.fetchedFeature(election))
            } catch {
                print("error with featured election parsing")
            }
            
        }
    }
}

extension KeyedDecodingContainer {
    public func decode<T: Decodable>(for key: K) throws -> T {
        return try decode(T.self, forKey: key)
    }
}
