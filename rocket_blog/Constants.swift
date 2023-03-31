//
//  Constants.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import UIKit
import CoreGraphics

import UIKit
import CoreGraphics

class K {
    
    struct URLs {
        static let baseURL = "https://rocket.vortigo.tech"
        static let registerEndpoint = "/register"
        static let loginEndpoint = "/auth/login"
        static let homeEndpoint = "/users/me"
        static let featuredPostsEndpoint = "/posts/featured"
        static let peopleCardsEndpoint = "/users/featured"
    }
    
    struct Regex {
        static let regexName = "[A-Z][a-z].* [A-Z][a-z].*"
        static let regexEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let regexPasswordDigits = ".*[0-9]+.*"
        static let regexPasswordAlphabet = ".*[A-Za-z]+.*"
        static let regexPasswordEspecialCharacter = ".*[!?()@#$%^<&>*]+.*"
    }
    
    struct ViewName {
        static let loginScreen = "LoginScreen"
        static let loginScreenId = "loginID"
        static let registerScreen = "RegisterScreen"
        static let registerScreenId = "registerID"
        static let modalErrorCustom = "ModalErrorCustom"
        static let loadingView = "LoadingView"
        static let textFieldCustom = "TextFieldCustom"
        static let homeScreen = "HomeScreen"
        static let homeScreenId = "homeID"
        static let forYouXibName = "ForYouCollectionCell"
        static let forYouIdCell = "forYouIdCell"
        static let detailPostScreen = "DetailPostScreen"
        static let detailPostId = "detailPostId"
        static let peopleCollectionCell = "PeopleCollectionCell"
        static let peopleIdCell = "peopleIdCell"
    }
    
    struct Colors {
        static let blueJames = "Azul james"
        static let mediumGray = "Cinza medio"
        static let lightGray = "Cinza Light"
        static let redError = "Vermelho"
        static let pinkJessie = "Rosa Jessie"
        static let grayStrongLight = "Cinza Claro"
        static let strongGray = "Cinza Escuro"
    }
    
    struct DefaultValues {
        static let cornerRadius: CGFloat = 26
        static let borderWidth: CGFloat = 1
        static let fontSize: CGFloat = 14.0
        static let minimumCharactersPassword: Int = 6
        static let defaultBackgroundInCollection: String = "DefaultBackground"
        static let defaultAvatarInCollection: String = "person.fill"
    }
    
    struct Fonts {
        static let montserratBold: String = "Montserrat-Bold"
        static let montserratSemiBold: String = "Montserrat-SemiBold"
    }
    
    struct MessageError {
        static let nameError = "Formato do nome inválido"
        static let emailError = "Formato de email inválido"
        static let passwordError = "Deve conter 1 letra, 1 número, 1 caracter especial e ter 6 ou mais caracteres"
        static let confirmPasswordError = "A confirmação de senha deve ser idêntica à senha."
        static let genericErrorMsg = "Ops! Houve algum problema. Não conseguimos obter os dados, tente novamente."
    }
    
    struct Placeholders {
        static let email = "E-mail"
        static let password = "Senha"
        static let name = "Nome Completo"
        static let confirmPassword = "Confirmação de senha"
    }
    
    struct GeneralMessages {
        static let messageGreeting = "Olá, "
        static let welcomeMessage = "Bem vindo!"
        static let newAccountMessage = "Criar nova conta?"
        static let subscribeMessage = "Inscrever-se"
        static let loginTitleButton = "Login"
        static let isAlreadyRegsiter = "Você já é inscrito?"
    }
    
    struct ProjectImages {
        static let backgroundLandingPage = "backgroundLandingPage"
        static let ladingPageLogo = "LadingPageLogo"
        static let logoRegister = "logoRegister"
        static let arrowBack = "arrowBack"
        static let envelopImage = "envelop"
        static let padlockImage = "padlock"
        static let personImage = "person"
    }
}
