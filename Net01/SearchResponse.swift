//
//  SearchResponse.swift
//  Net01
//
//  Created by Alexey Pavlov on 24.02.2021.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Repositories]
}

struct Repositories: Decodable {
    let login: String
    let name: String
    let description: String
    let avatar_url: String
}
