//
//  ConversationViewController.swift
//  GithubDM
//
//  Created by Satish on 10/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
    fileprivate var receiver: User
    fileprivate var currentUser: User

    var viewModel: MessagesViewModel = MessagesViewModel()

    var tableView: UITableView!

    var messageInputBar: MessageInputBar!

    var bottomConstraint: NSLayoutConstraint?

    init(with receiver: User) {
        self.receiver = receiver
        currentUser = User(id: 101, login: "ghost", avatarURL: "", url: "")
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        configureKeybordEvents()
        setupViewModelEvents()
        viewModel.fetchMessages()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

    private func setupViews() {
        title = "@\(receiver.login)"
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = #colorLiteral(red: 0.9719446301, green: 0.9719673991, blue: 0.9719551206, alpha: 1)

        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .interactive
        tableView.register(LeftMessageViewCell.self, forCellReuseIdentifier: "LeftMessageViewCell")
        tableView.register(RightMessageViewCell.self, forCellReuseIdentifier: "RightMessageViewCell")
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        view.addSubview(tableView)

        messageInputBar = MessageInputBar()
        messageInputBar.translatesAutoresizingMaskIntoConstraints = false
        messageInputBar.btnSend.addTarget(self, action: #selector(ConversationViewController.sendMessage(_:)), for: UIControl.Event.touchUpInside)
        view.addSubview(messageInputBar)
    }

    private func setupLayout() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: messageInputBar.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        messageInputBar.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true

        messageInputBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        messageInputBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        bottomConstraint = messageInputBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint?.priority = UILayoutPriority.defaultLow
        bottomConstraint?.isActive = true
    }

    private func setupViewModelEvents() {
        viewModel.didFinishFetch = { [weak self] in
            if self == nil {
                return
            }
            DispatchQueue.main.async { [weak self] in
                if self == nil {
                    return
                }
                self?.tableView.reloadData()
            }
        }
    }

    @objc func sendMessage(_: UIButton) {
        messageInputBar.txtView.resignFirstResponder()
        if messageInputBar.txtView.text.isEmpty {
            return
        }
        let message = Message(text: messageInputBar.txtView.text, sender: currentUser.login, receiver: receiver.login, date: Date())
        viewModel.addMessage(message: message)
        messageInputBar.txtView.text = ""
    }
}

extension ConversationViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.messages[indexPath.row]

        if message.sender == currentUser.login {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightMessageViewCell", for: indexPath) as! RightMessageViewCell
            cell.configure(with: message)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMessageViewCell", for: indexPath) as! LeftMessageViewCell
            cell.configure(with: message)
            return cell
        }
    }
}

extension ConversationViewController {
    private func configureKeybordEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(ConversationViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ConversationViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height
            }
            view.setNeedsLayout()
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0 {
                view.frame.origin.y += keyboardSize.height
            }
            view.setNeedsLayout()
        }
    }
}
