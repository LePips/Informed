//
//  ElectionViewControllerHandler.swift
//  Informed
//
//  Created by Ethan Pippin on 3/7/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import Foundation
import SharedPips

class ElectionViewControllerHandler {
    
    private(set) var articles: [Article] = []
    var newsCellDelegate: NewsCellDelegate?
    
    func getArticles(with keyword: String) {
        News.getFor(keyword) { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.newsCellDelegate?.didLoadArticles()
            }
        }
    }
}
