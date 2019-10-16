//
//  UsersViewModel.swift
//  GithubDM
//
//  Created by Satish on 10/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

import Foundation

class UsersViewModel {
    var users: [User] = [] {
        didSet {
            didFinishFetch?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            updateLoadingState?()
        }
    }

    var operationQueue: OperationQueue = OperationQueue()

    var didFinishFetch: (() -> Void)?
    var updateLoadingState: (() -> Void)?

    func fetchUsers() {
        isLoading = true
        RESTClient.users.request(type: [User].self) { [weak self] result in
            if self == nil {
                return
            }
            self?.isLoading = false
            switch result {
            case let .success(users):
                self?.users = users
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func downloadImage(url: String, completionHandler: @escaping (RESTResult<Data>) -> Void) {
        operationQueue.addOperation {
            FileDownloader().download(file: url, completionHandler: completionHandler)
        }
    }
}
