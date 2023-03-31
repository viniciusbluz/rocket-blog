//
//  UserTextValidade.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

struct UserTextValidate {
    var name: Bool
    var email: Bool
    var password: Bool
    var confirmPassword: Bool
    
    func isReadyToRegister() -> Bool {
        if name && email && password && confirmPassword {
            return true
        } else {
            return false
        }
    }
    
    func isReadytoLogin() -> Bool {
        if email && password {
            return true
        } else {
            return false
        }
    }
}


