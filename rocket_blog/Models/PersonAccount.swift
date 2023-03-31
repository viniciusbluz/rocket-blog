//
//  PersonAccount.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import Foundation

struct PersonAccount: Codable {
    var name: String
    var email: String
    var password: String
    var confirmPassword: String
}

