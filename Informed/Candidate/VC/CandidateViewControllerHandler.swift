//
//  NewsCellHandler.swift
//  Informed
//
//  Created by Ethan Pippin on 3/5/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import Foundation
import SharedPips

class CandidateViewControllerHandler {
    
    private(set) var articles: [Article] = []
    private(set) var elections: [Election] = []
    var candidateRowDelegate: CandidateRowDelegate?
    var newsCellDelegate: NewsCellDelegate?
    
    func getArticles(with keyword: String) {
        News.getFor(keyword) { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.newsCellDelegate?.didLoadArticles()
            }
        }
    }
    
    func getElections(with candidate: Candidate) {
        candidate.getElections { (elections) in
            self.elections = elections
            DispatchQueue.main.async {
                self.candidateRowDelegate?.didLoadElections()
            }
        }
    }
}
