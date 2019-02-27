//
//  Article.swift
//  Informed
//
//  Created by Ethan Pippin on 2/27/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import Foundation

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: Date
    
    struct Source: Codable {
        let id: String?
        let name: String?
    }
}
