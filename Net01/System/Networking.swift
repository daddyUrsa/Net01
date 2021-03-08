//
//  Networking.swift
//  Net01
//
//  Created by Alexey Golovin on 18.02.2021.
//

import Foundation

final class Networking {

    let scheme = "https"
    let host = "api.github.com"
    let hostPath = "https://api.github.com"
    let userPath = "/user"
    let searchRepoPath = "/search/repositories"
    let defaultHeaders = [
        "Content-Type" : "application/json",
        "Accept" : "application/vnd.github.v3+json"
        
    ]
    let authHeader = [
        "Authorization": "token e5213d68dd0f5ad36e2cd97d60c992f4949628c7"
    ]
    let sharedSession = URLSession.shared

    var model: [Items] = []
    var user: User?

    func searchRepositoriesRequest(repository: String, language: String, order: String) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = searchRepoPath
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "\(repository)+language:\(language)"),
            URLQueryItem(name: "order", value: order)
        ]
        print(urlComponents)
        guard let url = urlComponents.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = defaultHeaders
        return request
    }
    
    func authorizationRequest(token: String, completion: @escaping () -> ()) {
        let authHeader = [
            "Authorization": "token \(token)"
        ]
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = userPath
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = authHeader
        print(request)
        
        let dataTask = sharedSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("http status code: \(httpResponse.statusCode)")
                }

                guard let data = data else {
                    print("no data received")
                    return
                }
                do {
                    let user: User = try JSONDecoder().decode(User.self, from: data)
                    self.user = user
                    print(user)
                } catch let jsonError {
                    print("Failed JSON decode - нихуя не работает", jsonError)
                }
                completion()
            }
        }
        dataTask.resume()
    }

    func performSearchRepoRequest(repository: String, language: String, order: Int, completion: @escaping () -> ()) {
        guard let urlRequest = searchRepositoriesRequest(
            repository: repository,
            language: language,
            order: order == 0 ? "asc" : "desc"
        ) else {
            print("url request error")
            return
        }

        let dataTask = sharedSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("http status code: \(httpResponse.statusCode)")
                }

                guard let data = data else {
                    print("no data received")
                    return
                }

                do {
                    let repositories: Repos = try JSONDecoder().decode(Repos.self, from: data)
                    self.model = repositories.items
                } catch let jsonError {
                    print("Failed JSON decode", jsonError)
                }
                completion()
            }
        }
        dataTask.resume()
    }
}
