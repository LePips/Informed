//
//  ArticleView.swift
//  Informed
//
//  Created by Ethan Pippin on 2/27/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class ArticleView: BasicView {
    
    private lazy var sourceLabel = makeSourceLabel()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var dateLabel = makeDateLabel()
    private lazy var imageView = makeImageView()
    private lazy var tapRecognizer = makeTapRecognizer()
    private var article: Article?
    private var delegate: NewsCellDelegate?
    
    func configure(with article: Article, delegate: NewsCellDelegate) {
        self.article = article
        self.delegate = delegate
        
        sourceLabel.text = article.source.name
        titleLabel.text = article.title
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        let formattedDate = formatter.string(from: article.publishedAt)
        dateLabel.text = String(describing: formattedDate)
        imageView.kf.setImage(with: article.urlToImage)
    }
    
    override func setupSubviews() {
        addSubview(sourceLabel)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(imageView)
        addGestureRecognizer(tapRecognizer)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor ⩵ topAnchor,
            imageView.rightAnchor ⩵ rightAnchor - Metrics.CellInsets.rightPadding,
            imageView.widthAnchor ⩵ 96,
            imageView.heightAnchor ⩵ 96
            ])
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor ⩵ topAnchor,
            sourceLabel.leftAnchor ⩵ leftAnchor + Metrics.CellInsets.leftPadding,
            ])
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor ⩵ leftAnchor + Metrics.CellInsets.leftPadding,
            dateLabel.bottomAnchor ⩵ imageView.bottomAnchor
            ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor ⩵ sourceLabel.bottomAnchor + 4,
            titleLabel.leftAnchor ⩵ leftAnchor + Metrics.CellInsets.leftPadding,
            titleLabel.rightAnchor ⩵ imageView.leftAnchor - 15,
            titleLabel.bottomAnchor ⩵ dateLabel.topAnchor - 4
            ])
    }
    
    private func makeSourceLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.Informed.Text.grey
        return label
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 3
        return label
    }
    
    private func makeDateLabel() -> UILabel {
        let label = UILabel.forAutoLayout()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor.Informed.Text.grey
        return label
    }
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView.forAutoLayout()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func makeTapRecognizer() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(tapped))
    }
    
    @objc private func tapped() {
        guard let article = article else { return }
        delegate?.articleWasSelected(article)
    }
}
