//
//  Auth.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import Foundation

class Auth {
    var accessToken: String = ""
    static let shared = Auth()
    
    static func getToken() -> String {
        "Bearer \(shared.accessToken)"
    }
}
