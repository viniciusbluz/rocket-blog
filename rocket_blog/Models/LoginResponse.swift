//
//  LoginResponse.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//
import Foundation

struct LoginResponse: Codable {
    let status: String
    let errors: [ErrorStruct]?
    let data: AccessToken?
}

struct AccessToken: Codable {
    let accessToken: String
}
