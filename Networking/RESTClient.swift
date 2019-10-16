//
//  RESTClient.swift
//  GithubDM
//
//  Created by Satish on 09/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

import Foundation

enum RESTClient {
    case users
}

extension RESTClient {
    /// A dictionary containing all the HTTP header fields
    fileprivate var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"] // "Authorization": Application.Auth.bearerToken()
        }
    }

    /// The URL of the receiver.
    internal var url: String {
        return host + path
    }

    /// The host, conforming to RFC 1808.
    fileprivate var host: String {
        return "https://api.github.com"
    }

    /// The path, conforming to RFC 1808
    fileprivate var path: String {
        // return "/api/v1/" + endpoint
        return "/" + endpoint
    }

    /// API Endpoint
    fileprivate var endpoint: String {
        switch self {
        case .users:
            return "users"
        }
    }

    /// The HTTP request method.
    fileprivate var method: String {
        return "GET"
    }

    /// The HTTP request parameters.
    fileprivate var parameters: [String: Any]? {
        return nil
    }
}

extension RESTClient {
    func request<T: Codable>(type: T.Type, completionHandler: @escaping (RESTResult<T>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(RESTError.badURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                completionHandler(.failure(RESTError.parametersSerialization))
                return
            }
        }

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, responce, error) -> Void in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            if let responce = responce as? HTTPURLResponse {
                if responce.statusCode == 200 || 200 ..< 300 ~= responce.statusCode {
                    if let data = data {
                        do {
                            completionHandler(.success(try JSONDecoder().decode(type, from: data)))
                        } catch {
                            completionHandler(.failure(error))
                            return
                        }
                    }

                } else if responce.statusCode == 429 {
                    completionHandler(.failure(RESTError.tooManyRequests))
                }

            } else {
                completionHandler(.failure(RESTError.responceParsingError))
            }

        })

        dataTask.resume()
    }
}

class FileDownloader {
    var dataTask: URLSessionDataTask = URLSessionDataTask()

    deinit {
        dataTask.cancel()
    }

    func download(file url: String, completionHandler: @escaping (RESTResult<Data>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(RESTError.badURL))
            return
        }

        let request = URLRequest(url: url)

        let session = URLSession.shared
        dataTask = session.dataTask(with: request, completionHandler: { (data, _, error) -> Void in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            if let data = data {
                completionHandler(.success(data))
            }

        })

        dataTask.resume()
    }
}
