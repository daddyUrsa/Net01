//
//  SearchViewController.swift
//  Net01
//
//  Created by Alexey Golovin on 18.02.2021.
//

import UIKit

class SearchViewController: UIViewController {
    private let networking = Networking()

    let profileName: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()
        imageView.image = UIImage(named: "profile")

        return imageView
    }()
    
    private let repoName: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "repository name"
        label.borderStyle = .line
        label.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.placeholderPpaddingLeft, height: label.frame.height))
        label.leftViewMode = .always

        return label
    }()

    private let language: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "language"
        label.borderStyle = .line
        label.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.placeholderPpaddingLeft, height: label.frame.height))
        label.leftViewMode = .always

        return label
    }()
    
    private let ascDescSegment: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(withTitle: "Asc", at: 0, animated: true)
        segment.insertSegment(withTitle: "Desc", at: 1, animated: true)
        segment.selectedSegmentIndex = 0
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        return segment
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start search", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
    }
    
    @objc func searchButtonTapped() {
        let repoVC = RepoTableViewController()
        networking.performSearchRepoRequest(repository: repoName.text ?? "", language: language.text ?? "", order: ascDescSegment.selectedSegmentIndex) {
            repoVC.repoArray = self.networking.model
            repoVC.updateTableView()
        }
        self.navigationController?.pushViewController(repoVC, animated: true)
    }
    
    private func setupViews() {
        view.addSubviews(profileName, profileImage, repoName, language, ascDescSegment, searchButton)
        
        NSLayoutConstraint.activate([
            profileName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            profileName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 30),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 200),
            profileImage.heightAnchor.constraint(equalToConstant: 200),
            repoName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 50),
            repoName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            repoName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            language.topAnchor.constraint(equalTo: repoName.bottomAnchor, constant: 10),
            language.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            language.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            ascDescSegment.topAnchor.constraint(equalTo: language.bottomAnchor, constant: 10),
            ascDescSegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            ascDescSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            searchButton.topAnchor.constraint(equalTo: ascDescSegment.bottomAnchor, constant: 50),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}


