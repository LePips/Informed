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
    let coverImageString: String?
    let imageUrls: [String]?
    let type: CandidateType
    let elections: [Int]
    let sections: [[String: String]]
    
    enum CodingKeys: String, CodingKey {
        case first
        case last
        case coverImageString = "cover_image_string"
        case imageUrls = "image_urls"
        case type
        case elections
        case sections
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.first = try container.decode(for: .first)
        self.last = try container.decode(for: .last)
        self.coverImageString = try container.decode(for: .coverImageString)
        self.imageUrls = try container.decode(for: .imageUrls)
        self.type = try container.decode(for: .type)
        self.elections = try container.decode(for: .elections)
        self.sections = try container.decode(for: .sections)
    }
    
    init(first: String, last: String, coverImageString: String? = nil, imageUrls: [String]? = nil, type: CandidateType, elections: [Int], sections: [[String: String]]) {
        self.first = first
        self.last = last
        self.coverImageString = coverImageString
        self.imageUrls = imageUrls
        self.type = type
        self.elections = elections
        self.sections = sections
    }
    
    static func empty() -> Candidate {
        return Candidate(first: "", last: "", type: .None, elections: [], sections: [[:]])
    }
    
    static func getCandidates() {
        let url = Strings.URL.baseUrl + "candidates/"
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
                    CandidateState.core.fire(.fetchedAll(candidates))
                } catch {
                    return
                }
            }
        }
    }
    
    static func getCandidate(id: Int) {
        let url = Strings.URL.baseUrl + "candidates/\(id)"
        Internet.GET(url: URL(string: url)!) { (response) in
            if let error = response.error {
                print(error)
                return
            }
            if let value = response.value {
                do {
                    let candidate = try JSONDecoder().decode(Candidate.self, from: value.data)
                    CandidateState.core.fire(.fetchedSingle(candidate))
                } catch {
                    return
                }
            }
        }
    }
}
