//
//  RepoTableViewCell.swift
//  Net01
//
//  Created by Alexey Golovin on 23.02.2021.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    private let repoName: UILabel = {
        let label = UILabel()
        label.text = "Repo name"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let repoDescription: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let authorName: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let authorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()

        return imageView
    }()
    
    private let leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.backgroundColor = .red
        
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubviews(repoName, repoDescription)
        leftStackView.addArrangedSubview(repoName)
        leftStackView.addArrangedSubview(repoDescription)
        rightStackView.addArrangedSubview(authorName)
        rightStackView.addArrangedSubview(authorImage)
        mainStackView.addArrangedSubview(leftStackView)
        mainStackView.addArrangedSubview(rightStackView)
        NSLayoutConstraint.activate([
            repoName.topAnchor.constraint(equalTo: self.topAnchor),
            repoName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            repoDescription.topAnchor.constraint(equalTo: repoName.bottomAnchor),
            repoDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor)
//            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
//            mainStackView.leadingAnchor.constraint(equalTo: self.leftAnchor),
//            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
