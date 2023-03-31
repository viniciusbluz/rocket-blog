//
//  RegisterResponse.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import Foundation

struct RegisterResponse: Codable {
    let status: String
    let errors: [ErrorStruct]?
    let data: DataApi?
}

struct DataApi: Codable {
    let name: String
    let email: String
}
