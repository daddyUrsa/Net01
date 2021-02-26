//
//  RepoTableViewCell.swift
//  Net01
//
//  Created by Alexey Golovin on 23.02.2021.
//

import UIKit
import Kingfisher

final class RepoTableViewCell: UITableViewCell {
    private let repoName: UILabel = {
        let label = UILabel()
        label.text = "Repo name"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let repoDescription: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let authorName: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let authorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()

        return imageView
    }()

    func cellDataFill(repo: Items) {
        repoName.text = repo.name
        authorName.text = repo.full_name
        repoDescription.text = repo.description
        let url = URL(string: repo.owner.avatar_url)
        authorImage.kf.setImage(with: url)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(repoName)
        contentView.addSubview(repoDescription)
        contentView.addSubview(authorName)
        contentView.addSubview(authorImage)
        NSLayoutConstraint.activate([
            repoName.topAnchor.constraint(equalTo: contentView.topAnchor),
            repoName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.paddingLeft),
            repoDescription.topAnchor.constraint(equalTo: repoName.bottomAnchor),
            repoDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.paddingLeft),
            repoDescription.heightAnchor.constraint(equalToConstant: 42),
            repoDescription.widthAnchor.constraint(equalToConstant: (contentView.frame.width * 0.7)),
            repoDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            authorName.topAnchor.constraint(equalTo: contentView.topAnchor),
            authorName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorName.widthAnchor.constraint(equalToConstant: (contentView.frame.width * 0.3)),
            authorImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            authorImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            authorImage.widthAnchor.constraint(equalToConstant: 40),
            authorImage.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
