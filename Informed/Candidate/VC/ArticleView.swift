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
    
    func configure(with article: Article) {
        sourceLabel.text = article.source.name
        titleLabel.text = article.title
        dateLabel.text = String(describing: article.publishedAt)
        imageView.kf.setImage(with: article.urlToImage)
    }
    
    override func setupSubviews() {
        addSubview(sourceLabel)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(imageView)
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor ⩵ topAnchor,
            imageView.rightAnchor ⩵ rightAnchor - 30,
            imageView.widthAnchor ⩵ 96,
            imageView.heightAnchor ⩵ 96
            ])
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor ⩵ topAnchor,
            sourceLabel.leftAnchor ⩵ leftAnchor + 30,
            ])
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor ⩵ leftAnchor + 30,
            dateLabel.bottomAnchor ⩵ bottomAnchor
            ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor ⩵ sourceLabel.bottomAnchor + 4,
            titleLabel.leftAnchor ⩵ leftAnchor + 30,
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
}
