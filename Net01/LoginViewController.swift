//
//  LoginViewController.swift
//  Net01
//
//  Created by Alexey Pavlov on 15.02.2021.
//

import UIKit
import Kingfisher

final class LoginViewController: UIViewController {

    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()

        return imageView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = .red
        activity.isHidden = true

        return activity
    }()

    private let userName: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "username"
        label.borderStyle = .line

        return label
    }()

    private let password: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "password"
        label.borderStyle = .line

        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        return button
    }()
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setImage()
    }
    
    @objc func loginButtonTapped() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(logoImage)
        view.addSubview(activityIndicator)
        view.addSubview(userName)
        view.addSubview(password)
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 150),
            logoImage.widthAnchor.constraint(equalToConstant: 250),
            activityIndicator.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            userName.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 80),
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            password.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 30),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    func setImage() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        let imageURL = URL(string: "https://github.githubassets.com/images/modules/logos_page/Octocat.png")
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = imageURL, let _ = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    self.logoImage.image = UIImage(named: "denied")
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
                return
            }
            DispatchQueue.main.async {
                self.logoImage.kf.setImage(with: url)
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }

        }
    }
}


// Команды запросов
/*
curl https://api.github.com/users/elegion
 curl https://api.github.com/search/repositories?q=tetris+language:java

*/
