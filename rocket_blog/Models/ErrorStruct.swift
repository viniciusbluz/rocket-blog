//
//  ErrorStruct.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import Foundation

struct ErrorStruct: Codable {
    let value: String
    let msg: String
    let param: String
    let location: String
}



