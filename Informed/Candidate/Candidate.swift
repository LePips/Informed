//
//  Candidate.swift
//  Informed
//
//  Created by Ethan Pippin on 6/7/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

struct Candidate: Codable {
    let name: String
    let imageString: String?
    let bio: String
    
    
    static func single() -> Candidate {
        let image = "https://s.newsweek.com/sites/www.newsweek.com/files/styles/lg/public/2017/06/05/gettyimages-158574104.jpg"
        return Candidate(name: "Ethan Pippin", imageString: image, bio: "A man running for president.")
    }
    
    static func getCandidates() {
        Internet.GET(url: Firenet.candidates) { response in
            
            guard let data = response.value?.data else { return }
            
            do {
                let candidates = try JSONDecoder().decode([Candidate].self, from: data)
                CandidateState.core.fire(.fetchedSingle(candidates[0]))
            } catch {
                print("error with json parsing")
            }
        }
    }
}
