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
    let searchRepoPath = "/search/repositories"
    let defaultHeaders = [
        "Content-Type" : "application/json",
        "Accept" : "application/vnd.github.v3+json"
    ]
    let sharedSession = URLSession.shared

    var model: [Items] = []

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

    func performSearchRepoRequest(repository: String, language: String, order: Int) {
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

//                guard let text = String(data: data, encoding: .utf8) else {
//                    print("data encoding failed")
//                    return
//                }
                do {
                    let repositories: Repos = try JSONDecoder().decode(Repos.self, from: data)
                    self.model = repositories.items
//                    self.model.forEach { print($0.description) }
                } catch let jsonError {
                    print("Failed JSON decode - нихуя не работает", jsonError)
                }

    //            print("received data: \(text)")
    //            print(repositories)
            }
        }
        dataTask.resume()
    }
}
