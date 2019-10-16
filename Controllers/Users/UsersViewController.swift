//
//  UsersViewController.swift
//  GithubDM
//
//  Created by Satish on 09/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    private var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!

    var viewModel: UsersViewModel = UsersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()

        viewModel.fetchUsers()
        viewModel.didFinishFetch = {
            DispatchQueue.main.async { [weak self] in
                if self == nil {
                    return
                }
                self?.tableView.reloadData()
            }
        }

        viewModel.updateLoadingState = {
            DispatchQueue.main.async { [weak self] in
                if self == nil {
                    return
                }
                switch self!.viewModel.isLoading {
                case true:
                    self!.activityIndicator.startAnimating()
                case false:
                    self!.activityIndicator.stopAnimating()
                }
            }
        }
    }

    private func setupViews() {
        title = "GitHub DM"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white

        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    private func setupLayout() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UsersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UsersTableViewCell
        cell.configure(user: viewModel.users[indexPath.row])

        downloadImage(indexPath, cell)

        return cell
    }

    fileprivate func downloadImage(_: IndexPath, _: UsersTableViewCell) {
//        print(viewModel.users[indexPath.row].avatarURL)
//        viewModel.downloadImage(url: viewModel.users[indexPath.row].avatarURL) { (result) in
//            switch result {
//
//            case .success(let data):
//                cell.imgAvarar.image = UIImage.init(data: data)
//            case .failure(_):
//                break
//            }
//        }
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(ConversationViewController(with: viewModel.users[indexPath.row]), animated: true)
    }
}
