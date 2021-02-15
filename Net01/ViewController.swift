//
//  ViewController.swift
//  Net01
//
//  Created by Alexey Pavlov on 15.02.2021.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let userName: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "username"

        return label
    }()

    let password: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "password"

        return label
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        let url = URL(string: "https://github.githubassets.com/images/modules/logos_page/Octocat.png")
        logoImage.kf.setImage(with: url)
    }

    func setupViews() {
        view.addSubview(logoImage)
        view.addSubview(userName)
        view.addSubview(password)
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 170),
            logoImage.widthAnchor.constraint(equalToConstant: 204),
            userName.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 80),
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 30),
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

