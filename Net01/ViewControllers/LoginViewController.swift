//
//  LoginViewController.swift
//  Net01
//
//  Created by Alexey Pavlov on 15.02.2021.
//

import UIKit
import Kingfisher

final class LoginViewController: UIViewController {
    private let networking = Networking()
    private let authTouchFace = AuthTouchFace()
    private let keychain = Keychain()
    let searchVC = SearchViewController()

    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        let imageURL = URL(string: "https://github.githubassets.com/images/modules/logos_page/Octocat.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.kf.setImage(with: imageURL)
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

    private let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.isHidden = true

        return label
    }()

    private let token: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = Constants.tokenPlaceholder
        label.borderStyle = .line
        label.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.placeholderPpaddingLeft, height: label.frame.height))
        label.leftViewMode = .always

        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.loginButton, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        return button
    }()
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let token = keychain.readPassword(service: "newager", account: "github") {
            authTouchFace.authenticateUser {
                self.networkingAuthorizationRequest(token: token)
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(self.searchVC, animated: true)
                }
            }
        }
    }
    
    @objc func loginButtonTapped() {
        let result = keychain.savePassword(password: token.text!, service: "newager", account: "github")
        //Для отладки
        if result, let savedPassword = keychain.readPassword(service: "newager", account: "github") {
            print("password:\(savedPassword) saved successfully.")
        } else {
            print("can't save password")
        }
        
        networkingAuthorizationRequest(token: token.text!)
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func networkingAuthorizationRequest(token: String) {
        networking.authorizationRequest(token: token, completion: {
            guard let avatarImageURL = self.networking.user?.avatarURL else { return }
            self.searchVC.profileImage.kf.setImage(with: URL(string: avatarImageURL))
            let userNameText = self.networking.user?.userName ?? ""
            self.searchVC.profileName.text = "Hello, \(userNameText)"
        })
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubviews(logoImage, activityIndicator, userName, token, loginButton)

        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 150),
            logoImage.widthAnchor.constraint(equalToConstant: 150),
            activityIndicator.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            userName.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 80),
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            token.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 30),
            token.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            token.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.topAnchor.constraint(equalTo: token.bottomAnchor, constant: 50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}




// Команды запросов
/*
curl https://api.github.com/users/elegion
 curl https://api.github.com/search/repositories?q=tetris+language:java

*/

/*
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
 */
