//
//  Message.swift
//  GithubDM
//
//  Created by Satish on 10/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//
import UIKit

struct Message: Codable {
    var text: String
    var sender: String
    var receiver: String
    var date: Date
}
