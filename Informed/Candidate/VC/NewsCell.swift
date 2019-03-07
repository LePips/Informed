//
//  NewsCell.swift
//  Informed
//
//  Created by Ethan Pippin on 2/27/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class NewsCell: BasicTableViewCell, NeededHeight {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var articleStackView = makeArticleStackView()
    private lazy var loadingIndicator = makeLoadingIndicator()
    private var candidate: Candidate?
    private var delegate: CandidateRowDelegate?
    private var handler: NewsCellHandler?
    
    func configure(with candidate: Candidate, delegate: CandidateRowDelegate, handler: NewsCellHandler) {
        self.candidate = candidate
        self.delegate = delegate
        self.handler = handler
        
        makeArticleViews()
    }
    
    private func makeArticleViews() {
        if articleStackView.arrangedSubviews.count > 1 { return }
        guard let handler = handler else { return }
        guard let delegate = delegate else { return }
        guard let first = handler.articles.first else { return }
        if (handler.articles.count < 2) { return }
        let second = handler.articles[1]
        
        let firstView = ArticleView()
        firstView.configure(with: first, delegate: delegate)
        let secondView = ArticleView()
        secondView.configure(with: second, delegate: delegate)
        self.articleStackView.addArrangedSubview(firstView)
        self.articleStackView.addArrangedSubview(secondView)
        NSLayoutConstraint.activate([
            firstView.heightAnchor ⩵ 100,
            firstView.leftAnchor ⩵ leftAnchor,
            secondView.heightAnchor ⩵ 100,
            secondView.leftAnchor ⩵ leftAnchor
            ])
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
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
