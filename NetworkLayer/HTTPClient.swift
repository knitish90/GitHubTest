//
//  SceneDelegate.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

typealias networkCompletion = ((_ data : Data?, _ error : Errors?)-> Void)
typealias Params = [String: String]

enum HTTPMethod: String {
    case GET    =   "GET"
    case POST   =   "POST"
    case PUT    =   "PUT"
    case DELETE =   "DELETE"
}


protocol HTTPClientProtocol {
    func getData(urlString : String, completion : @escaping networkCompletion)
    func postData(urlString : String, body : Data?, completion : @escaping networkCompletion)
    func LoginPostData(authCode : String, completion: @escaping networkCompletion)
    func getGitHubUserProfile(urlString: String, accessToken: String, completion: @escaping networkCompletion)
}


struct HTTPClient : HTTPClientProtocol {

    private let session : URLSession
    
    init(session : URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getData(urlString: String, completion:@escaping (Data?, Errors?) -> Void) {
       
        if Reachability.isConnectedToNetwork() == false {
            return completion(nil,Errors(message: Constants.NetworkError.internetConnectionError))
        }
        guard let url = URLEncoder().encode(urlString, [:]) else {
            return completion(nil,Errors(message: Constants.NetworkError.inValidURLError))
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue

        session.dataTask(with: request) { (data, response, error) in
            completion(data, nil)
        }.resume()
    }
    
    func postData(urlString: String, body: Data?, completion: @escaping networkCompletion) {
        
        if Reachability.isConnectedToNetwork() == false {
            return completion(nil,Errors(message: Constants.NetworkError.internetConnectionError))
        }
        
        guard let url = URL(string: urlString) else {
            return completion(nil,Errors(message: Constants.NetworkError.inValidURLError))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod  =   HTTPMethod.POST.rawValue
        request.httpBody    =   body
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { (data, response, error) in
            completion(data, nil)
        }.resume()
    }

    
    func LoginPostData(authCode : String, completion: @escaping networkCompletion) {
        if Reachability.isConnectedToNetwork() == false {
            return completion(nil,Errors(message: Constants.NetworkError.internetConnectionError))
        }
        
        let grantType = "authorization_code"
        let params = "grant_type=\(grantType)&code=\(authCode)&client_id=\(EndPoint.GithubLogin.CLIENT_ID)&client_secret=\(EndPoint.GithubLogin.CLIENT_SECRET)"
        
        guard let url = URL(string: EndPoint.GithubLogin.TOKENURL) else {
            return completion(nil,Errors(message: Constants.NetworkError.inValidURLError))
        }
        
        let body = params.data(using: String.Encoding.utf8)
        var request = URLRequest(url: url)
        request.httpMethod  = HTTPMethod.POST.rawValue
        request.httpBody    = body
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTask(with: request as URLRequest) { (data, response, _) -> Void in
            completion(data, nil)
        }.resume()
    }
    
    func getGitHubUserProfile(urlString: String, accessToken: String, completion: @escaping networkCompletion) {
        if Reachability.isConnectedToNetwork() == false {
            return completion(nil,Errors(message: Constants.NetworkError.internetConnectionError))
        }
        
        guard let url = URL(string: urlString) else {
            return completion(nil,Errors(message: Constants.NetworkError.inValidURLError))
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            let result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print("result-",result)
            completion(data, nil)
        }
        task.resume()
    }
}
