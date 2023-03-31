//
//  VerifyRequestEnded.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

struct VerifyRequestEnded {
    static var headerRequest = false
    static var forYouRequest = false
    static var loader = LoadingView()

    static func checkIfRequestIsFinished() -> Bool {
        if headerRequest && forYouRequest {
            return true
        } else {
            return false
        }
    }
    
    static func dismissLoader(loader: LoadingView) {
        if checkIfRequestIsFinished() {
            loader.dismissLoadingView()
        }
    }
}

