//
//  RESTError.swift
//  GithubDM
//
//  Created by Satish on 09/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

enum RESTError: Error {
    case badURL
    case tooManyRequests
    case noInternet
    case responceParsingError
    case parametersSerialization
}

enum RESTResult<T> {
    case success(T)
    case failure(Error)
}
