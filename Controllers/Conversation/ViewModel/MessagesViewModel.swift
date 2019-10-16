//
//  MessagesViewModel.swift
//  GithubDM
//
//  Created by Satish on 10/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

import Foundation

class MessagesViewModel {
    var messages: [Message] = [] {
        didSet {
            didFinishFetch?()
        }
    }

    var didFinishFetch: (() -> Void)?

    func fetchMessages() {
        // TODO: Fetch messages from db
    }

    func addMessage(message: Message) {
        // TODO: Add message to db
        messages.append(message)
        registerEchoMessage(message: message)
    }

    func registerEchoMessage(message: Message) {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] _ in
            if self == nil {
                return
            }
            var echoMessage = message
            echoMessage.text = message.text + " " + message.text
            echoMessage.date = Date()
            echoMessage.sender = message.receiver
            echoMessage.receiver = message.sender
            self?.messages.append(echoMessage)
        }
    }
}
