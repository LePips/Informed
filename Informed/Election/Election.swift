//
//  Election.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

enum ElectionType: String, Codable {
    case National
    case State
    case None
}

struct Election: Codable {
    let title: String
    let id: Int
    let type: ElectionType
    let coverImageUrl: String?
    let imageUrls: [Int]?
    let date: String
    let candidates: [Int]
    let sections: [[String: String]]
    let lastEdited: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case id
        case type
        case coverImageUrl = "cover_image_url"
        case imageUrls = "image_urls"
        case date
        case candidates
        case sections
        case lastEdited = "last_edited"
    }
    
    init(with decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(for: .title)
        self.id = try container.decode(for: .id)
        self.type = try container.decode(for: .type)
        self.coverImageUrl = try container.decode(for: .coverImageUrl)
        self.imageUrls = try container.decode(for: .imageUrls)
        self.date = try container.decode(for: .date)
        self.candidates = try container.decode(for: .candidates)
        self.sections = try container.decode(for: .sections)
        self.lastEdited = try container.decode(for: .lastEdited)
    }
    
    init(title: String, id: Int, type: ElectionType, coverImageUrl: String?, imageUrls: [Int]?, date: String, candidates: [Int], sections: [[String: String]], lastEdited: String) {
        self.title = title
        self.id = id
        self.type = type
        self.coverImageUrl = coverImageUrl
        self.imageUrls = imageUrls
        self.date = date
        self.candidates = candidates
        self.sections = sections
        self.lastEdited = lastEdited
    }
    
    static func single() -> Election {
        let election = Election(title: "1800 Presidential", id: 1, type: .National, coverImageUrl: nil, imageUrls: nil, date: "", candidates: [], sections: [], lastEdited: "")
        return election
    }
    
    static func getElections(_ ids: [Int] = [], completion: @escaping ([Election]) -> Void) {
        var url = Strings.URL.baseUrl + "elections/"
        if !ids.isEmpty {
            url += "?ids="
            for id in ids {
                url += String(describing: id) + ","
            }
        }
        Internet.GET(url: url) { (response) in
            if let error = response.error {
                print(error)
                return
            }
            if let value = response.value {
                do {
                    let key = value.json["elections"] as! [JSON]
                    let electionData = try JSONSerialization.data(withJSONObject: key, options: .prettyPrinted)
                    let elections = try JSONDecoder().decode([Election].self, from: electionData)
                    completion(elections)
                } catch {
                    return
                }
            }
        }
    }
    
    static func getElection(id: Int, completion: @escaping (Election) -> Void) {
        let url = Strings.URL.baseUrl + "elections/\(id)"
        Internet.GET(url: URL(string: url)!) { (response) in
            if let error = response.error {
                print(error)
                return
            }
            if let value = response.value {
                do {
                    let election = try JSONDecoder().decode(Election.self, from: value.data)
                    completion(election)
                } catch {
                    return
                }
            }
        }
    }
    
    static func refreshElection(id: Int, completion: @escaping (Election) -> ()) {
        Election.getElection(id: id) { (election) in
            ElectionState.core.fire(.refreshedSingle(election))
            completion(election)
        }
    }
}

extension KeyedDecodingContainer {
    public func decode<T: Decodable>(for key: K) throws -> T {
        return try decode(T.self, forKey: key)
    }
}
