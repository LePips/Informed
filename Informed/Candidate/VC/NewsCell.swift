//
//  NewsCell.swift
//  Informed
//
//  Created by Ethan Pippin on 2/27/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

protocol NewsCellDelegate: class {
    func articleWasSelected(_ article: Article)
    func didLoadArticles()
}

class NewsCell: BasicTableViewCell, NeededHeight {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var articleStackView = makeArticleStackView()
    private lazy var loadingIndicator = makeLoadingIndicator()
    private var delegate: NewsCellDelegate?
    private var articles: [Article] = []
    
    func configure(with delegate: NewsCellDelegate, articles: [Article]) {
        self.delegate = delegate
        self.articles = articles
        
        makeArticleViews()
    }
    
    private func makeArticleViews() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
        if articleStackView.arrangedSubviews.count > 0 { return }
        guard let delegate = delegate else { return }
        guard let first = articles.first else { return }
        let firstView = ArticleView()
        firstView.configure(with: first, delegate: delegate)
        self.articleStackView.addArrangedSubview(firstView)
        NSLayoutConstraint.activate([
            firstView.heightAnchor ⩵ 100,
            firstView.leftAnchor ⩵ leftAnchor,
            ])
        
        
        if (articles.count < 2) { return }
        let second = articles[1]
        let secondView = ArticleView()
        secondView.configure(with: second, delegate: delegate)
        self.articleStackView.addArrangedSubview(secondView)
        NSLayoutConstraint.activate([
            secondView.heightAnchor ⩵ 100,
            secondView.leftAnchor ⩵ leftAnchor
            ])
    }
    
    private func addToHolderView(_ view: UIView) -> UIView {
        let holder = UIView.forAutoLayout()
        holder.addSubview(view)
        NSLayoutConstraint.activate([
            view.heightAnchor ⩵ 100
            ])
        return holder
    }
    
    override func setupSubviews() {
        addSubview(titleLabel)
        addSubview(articleStackView)
        addSubview(loadingIndicator)
        backgroundColor = .black
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor ⩵ topAnchor + Metrics.CellInsets.topPadding,
            titleLabel.leftAnchor ⩵ leftAnchor + Metrics.CellInsets.leftPadding
            ])
        NSLayoutConstraint.activate([
            articleStackView.topAnchor ⩵ titleLabel.bottomAnchor + 6,
            articleStackView.bottomAnchor ⩵ bottomAnchor,
            articleStackView.leftAnchor ⩵ leftAnchor,
            articleStackView.rightAnchor ⩵ rightAnchor
            ])
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor ⩵ centerXAnchor,
            loadingIndicator.centerYAnchor ⩵ centerYAnchor
            ])
    }
    
    static var neededHeight: CGFloat = 300
    static func neededHeight(for articles: [Article]) -> CGFloat {
        let base: CGFloat = 52
        var height: CGFloat = 121
        if articles.count > 2 {
            height *= 2
        }
        return base + height
    }
    
    private func getHeight() -> CGFloat {
        let titleLabelHeight = 30
        let articleCount = self.articleStackView.arrangedSubviews.count
        let articleCountHeight = articleCount * 100
        let height = titleLabelHeight + articleCountHeight
        return CGFloat(height)
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel.header()
        label.text = "News"
        return label
    }
    
    private func makeArticleStackView() -> UIStackView {
        let stackView = UIStackView.forAutoLayout()
        stackView.alignment = .bottom
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }
    
    private func makeLoadingIndicator() -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.startAnimating()
        indicatorView.color = UIColor.Informed.darkGrey
        return indicatorView
    }
}
