
import UIKit

class ValidateTextFields {
    static func invalidName(userName: String) -> String? {
        let regexName = K.Regex.regexName
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", regexName)
        if !namePredicate.evaluate(with: userName) {
            return K.MessageError.nameError
        }
        return nil
    }
    
    static func invalidEmail(userEmail: String) -> String? {
        let regexEmail = K.Regex.regexEmail
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regexEmail)
        if !emailPredicate.evaluate(with: userEmail) {
            return K.MessageError.emailError
        }
        return nil
    }
    
    static func invalidPassword(userPassword: String) -> String? {
        let errorMessage = K.MessageError.passwordError
        
        if userPassword.count < K.DefaultValues.minimumCharactersPassword {
            return errorMessage
        }
        
        if passwordContainsDigit(value: userPassword) {
            return errorMessage
        }
        
        if passwordContainsAlphabet(value: userPassword) {
            return errorMessage
        }
        
        if passwordContainsEspecialCharacter(value: userPassword) {
            return errorMessage
        }
        return nil
    }
    
    static func passwordContainsDigit(value: String) -> Bool {
        let regexPasswordDigits = K.Regex.regexPasswordDigits
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regexPasswordDigits)
        return !passwordPredicate.evaluate(with: value)
    }
    
    static func passwordContainsAlphabet(value: String) -> Bool {
        let regexPasswordAlphabet = K.Regex.regexPasswordAlphabet
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regexPasswordAlphabet)
        return !passwordPredicate.evaluate(with: value)
    }
    
    static func passwordContainsEspecialCharacter(value: String) -> Bool {
        let regexPasswordEspecialCharacter = K.Regex.regexPasswordEspecialCharacter
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regexPasswordEspecialCharacter)
        return !passwordPredicate.evaluate(with: value)
    }
}

