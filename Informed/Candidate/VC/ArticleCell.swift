//
//  ArticleCell.swift
//  Informed
//
//  Created by Ethan Pippin on 3/5/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class ArticleCell: BasicTableViewCell, NeededHeight {
    
    private lazy var articleView = makeArticleView()
    private var delegate: CandidateRowDelegate?
    
//    func configure(with article: Article) {
//        articleView.configure(with: article, delegate: )
//    }
    
    override func setupSubviews() {
        embed(articleView)
    }
    
    override func setupLayoutConstraints() {
        
    }
    
    static var neededHeight: CGFloat = 100
    
    private func makeArticleView() -> ArticleView {
        return ArticleView.forAutoLayout()
    }
}
