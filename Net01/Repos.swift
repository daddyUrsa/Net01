//
//  Repos.swift
//  Net01
//
//  Created by Alexey Pavlov on 25.02.2021.
//

import Foundation

struct Repos: Codable {
    var total_count: Int
    var items: [Items]
}

struct Items: Codable {
    var name: String
    var full_name: String
    var description: String?
    var owner: Owner
}

struct Owner: Codable {
    var avatar_url: String
}
