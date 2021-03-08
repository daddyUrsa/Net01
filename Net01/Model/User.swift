//
//  User.swift
//  Net01
//
//  Created by Alexey Golovin on 08.03.2021.
//

import Foundation

struct User: Codable {
    var name: String?
    var userName: String
    var avatarURL: String

    private enum CodingKeys: String, CodingKey {
        case userName = "login"
        case avatarURL = "avatar_url"
    }
}
