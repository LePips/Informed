//
//  Candidate.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

enum CandidateType: String, Codable {
    case National
    case State
    case Other
    case None
}

struct Candidate: Codable {
    let first: String
    let last: String
    let coverImage: URL?
    let images: [URL]?
    let type: CandidateType
    let elections: [Int]
    let sections: [[String: String]]
    let party: String
    var fullName: String {
        return first + " " + last
    }
    
    enum CodingKeys: String, CodingKey {
        case first
        case last
        case coverImage = "cover_image_url"
        case images = "image_urls"
        case type
        case elections
        case sections
        case party
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.first = try container.decode(for: .first)
        self.last = try container.decode(for: .last)
        self.coverImage = try container.decode(for: .coverImage)
        self.images = try container.decode(for: .images)
        self.type = try container.decode(for: .type)
        self.elections = try container.decode(for: .elections)
        self.sections = try container.decode(for: .sections)
        self.party = try container.decode(for: .party)
    }
    
    init(first: String, last: String, coverImageString: URL? = nil, imageUrls: [URL]? = nil, type: CandidateType, elections: [Int], sections: [[String: String]], party: String) {
        self.first = first
        self.last = last
        self.coverImage = coverImageString
        self.images = imageUrls
        self.type = type
        self.elections = elections
        self.sections = sections
        self.party = party
    }
    
    static func empty() -> Candidate {
        return Candidate(first: "", last: "", type: .None, elections: [], sections: [[:]], party: "")
    }
    
    func getElections(completion: @escaping ([Election]) -> ()) {
        Election.getElections(elections) { (elections) in
            completion(elections)
        }
    }
    
    static func getCandidates(_ ids: [Int] = [], completion: @escaping ([Candidate]) -> Void) {
        var url = Strings.URL.baseUrl + "candidates/"
        if !ids.isEmpty {
            url += "?ids="
            for id in ids {
                url += String(describing: id) + ","
            }
        }
        Internet.GET(url: URL(string: url)!) { (response) in
            if let error = response.error {
                print(error)
                return
            }
            if let value = response.value {
                do {
                    let key = value.json["candidates"] as! [JSON]
                    let candidateData = try JSONSerialization.data(withJSONObject: key, options: .prettyPrinted)
                    let candidates = try JSONDecoder().decode([Candidate].self, from: candidateData)
                    completion(candidates)
                } catch {
                    return
                }
            }
        }
    }
    
    static func getCandidate(id: Int, completion: @escaping (Candidate) -> Void) {
        let url = Strings.URL.baseUrl + "candidates/\(id)"
        Internet.GET(url: URL(string: url)!) { (response) in
            if let error = response.error {
                print(error)
                return
            }
            if let value = response.value {
                do {
                    let candidate = try JSONDecoder().decode(Candidate.self, from: value.data)
                    completion(candidate)
                } catch {
                    return
                }
            }
        }
    }
}
