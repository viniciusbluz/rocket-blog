//
//  FeaturedPostsResponse.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import Foundation

struct FeaturedPostsResponse: Codable {
    let status: String
    let data: FeaturedPosts?
    let errors: [ErrorStruct]?
}

struct FeaturedPosts: Codable {
    let featuredPosts: [UserInfo]
}

struct UserInfo: Codable {
    let title: String
    let image: String?
    let postedBy: [AuthorPost]
}

struct AuthorPost: Codable {
    let id: String
    let name: String
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case avatar
    }
    
}

