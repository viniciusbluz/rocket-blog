
import UIKit
   
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct NetworkingManager {

    private static func genericRequest(httpMethod: HttpMethod,
                                       userBody: [String : String] = [:],
                                       customURL: String,
                                       completionHandler: @escaping (Data?, Error?) -> ()) {
        
        guard let serviceURL = URL(string: customURL) else {
            return
        }
        var request = URLRequest(url: serviceURL)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Auth.getToken(), forHTTPHeaderField: "Authorization")
        if !userBody.isEmpty {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: userBody, options: []) else {
                return
            }
            request.httpBody = httpBody
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            completionHandler(data, error)
        }
        task.resume()
    }
    
    private static func genericJsonParse<T:Codable>(typeMethod: HttpMethod,
                                                    customURL: String,
                                                    bodyData: [String:String] = [:],
                                                    type: T.Type,
                                                    completionHandler: @escaping (T?, Error?) -> ()) {
        self.genericRequest(httpMethod: typeMethod, userBody: bodyData, customURL: customURL) { data, error in
            let decoder = JSONDecoder()
            do {
                if let data = data {
                    let parsedData = try decoder.decode(T.self, from: data)
                    completionHandler(parsedData, nil)
                } else {
                    completionHandler(nil, nil)
                }
            } catch {
                completionHandler(nil, error)
            }
        }
    }
    
    static func postLoginScreen(bodyLogin: [String:String], completion: @escaping (LoginResponse?, Error?) -> ()) {
        let postLoginUrl = K.URLs.baseURL + K.URLs.loginEndpoint
        self.genericJsonParse(typeMethod: .post,
                              customURL: postLoginUrl,
                              bodyData: bodyLogin,
                              type: LoginResponse.self) { loginReturn, error in
            DispatchQueue.main.async {
                completion(loginReturn, error)
            }
        }
    }
    
    static func postRegisterScreen(bodyRegister: [String:String], completion: @escaping (RegisterResponse?, Error?) -> ()) {
        let postRegisterUrl = K.URLs.baseURL + K.URLs.registerEndpoint
        self.genericJsonParse(typeMethod: .post,
                              customURL: postRegisterUrl,
                              bodyData: bodyRegister,
                              type: RegisterResponse.self) { registerReturn, error in
            DispatchQueue.main.async {
                completion(registerReturn, error)
            }
        }
    }
    
    static func getHomeScreen(completion: @escaping (UserInfoResponse?, Error?) -> ()) {
        let getHomeUrl = K.URLs.baseURL + K.URLs.homeEndpoint
        self.genericJsonParse(typeMethod: .get,
                              customURL: getHomeUrl,
                              type: UserInfoResponse.self) { homeReturn, error in
            DispatchQueue.main.async {
                completion(homeReturn, error)
            }
        }
    }
    
    static func getUsersPosts(completion: @escaping(FeaturedPostsResponse?, Error?) -> ()) {
        let getUserPostUrl = K.URLs.baseURL + K.URLs.featuredPostsEndpoint
        self.genericJsonParse(typeMethod: .get,
                              customURL: getUserPostUrl,
                              type: FeaturedPostsResponse.self) { userPostsReturn, error in
            DispatchQueue.main.async {
                completion(userPostsReturn, error)
            }
        }
    }
    
    static func getPeopleCards(completion: @escaping(PeopleCardsResponse?, Error?) -> ()) {
        let getCardsPeopleUrl = K.URLs.baseURL + K.URLs.peopleCardsEndpoint
        self.genericJsonParse(typeMethod: .get,
                              customURL: getCardsPeopleUrl,
                              type: PeopleCardsResponse.self) { peopleCardsReturn, error in
            DispatchQueue.main.async {
                completion(peopleCardsReturn, error)
            }
        }
    }
}

