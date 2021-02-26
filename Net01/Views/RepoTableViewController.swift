//
//  RepoTableViewController.swift
//  Net01
//
//  Created by Alexey Golovin on 23.02.2021.
//

import UIKit
//private let networking = Networking()

class RepoTableViewController: UIViewController {
    var repoArray: [Items] = []
    let cellID = "cellID"

    private let repoCount: UILabel = {
        let label = UILabel()
        label.text = "Repositories found: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped )
        let queue = DispatchQueue.global(qos: .utility)
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: cellID)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .white
        setupViews()
    }

    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print(self.repoArray)
        }
    }
    
    private func setupViews() {
        view.addSubviews(repoCount, tableView)
        NSLayoutConstraint.activate([
            repoCount.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            repoCount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: repoCount.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RepoTableViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let reposCount = repoArray.count
        return reposCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepoTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! RepoTableViewCell
        let cellData = repoArray[indexPath.row]
        cell.cellDataFill(repo: cellData)
        return cell
    }
}

extension UIViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
