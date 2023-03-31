//
//  UserInfoResponse.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import Foundation

struct UserInfoResponse: Codable {
    let status: String
    let data: UserDataInfoList?
    let errors: [ErrorStruct]?
}

struct UserDataInfoList: Codable {
    let avatar: String?
    let bio: String
    let name: String
    let email: String
    let background: String?
}


