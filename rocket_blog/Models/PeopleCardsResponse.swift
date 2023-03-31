//
//  PeopleCardsResponse.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import Foundation

struct PeopleCardsResponse: Codable {
    let status: String
    let data: Users
    let errors: [ErrorStruct]?
}

struct Users: Codable {
    let users: [PersonInfo]
}

struct PersonInfo: Codable {
    let id: String
    let name: String?
    let email: String
    let avatar: String?
    let bio: String?
    let background: String?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case email
        case avatar
        case bio
        case background
    }

}

