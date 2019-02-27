//
//  NewsCell.swift
//  Informed
//
//  Created by Ethan Pippin on 2/27/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class NewsCell: BasicTableViewCell {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var articleView = makeArticleView()
    private var delegate: CandidateRowDelegate?
    private var article: Article?
    
    private lazy var tapGestureRecognizer = makeTapGesture()
    
    func configure(with articles: [Article], delegate: CandidateRowDelegate) {
        guard let first = articles.first else { return }
        self.articleView.configure(with: first)
        self.delegate = delegate
        self.article = first
    }
    
    override func setupSubviews() {
        addSubview(titleLabel)
        addSubview(articleView)
        addGestureRecognizer(tapGestureRecognizer)
        backgroundColor = .black
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor ⩵ topAnchor,
            titleLabel.leftAnchor ⩵ leftAnchor + 30
            ])
        NSLayoutConstraint.activate([
            articleView.leftAnchor ⩵ leftAnchor,
            articleView.topAnchor ⩵ titleLabel.bottomAnchor + 6,
            articleView.rightAnchor ⩵ rightAnchor,
            articleView.bottomAnchor ⩵ bottomAnchor
            ])
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.text = "News"
        return label
    }
    
    private func makeArticleView() -> ArticleView {
        return ArticleView.forAutoLayout()
    }
    
    // MARK: -
    // MARK: DONT DO THIS
    private func makeTapGesture() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(tapped))
    }
    
    @objc private func tapped() {
        guard let article = self.article else { return }
        delegate?.articleCell(self, wasSelectedAt: IndexPath(row: 0, section: 0), with: article)
    }
}
