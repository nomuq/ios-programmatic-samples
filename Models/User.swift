//
//  User.swift
//  GithubDM
//
//  Created by Satish on 09/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

struct User: Codable {
    let id: Int
    let login: String
    let avatarURL: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
        case url
    }
}
