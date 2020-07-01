//
//  LoginService.swift
//  GitHub
//
//  Created by Nitish.kumar on 26/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol LoginServiceProtocol {
    func getGithubAccessToken(authCode: String, completion : @escaping (Errors?, AccessToken?) -> Void) 
    func getGitHubUserProfile(accessToken: String, completion : @escaping (Errors?, GitHubUser?) -> Void) 
}


class LoginService : LoginServiceProtocol{
    
    var httpHanlder : HTTPClientProtocol
    var responseHandler : ResponseHandler
    init(httpHanlder : HTTPClientProtocol, responseHandler: ResponseHandler) {
        self.httpHanlder        =   httpHanlder
        self.responseHandler    =   responseHandler
    }
    
    func getGithubAccessToken(authCode: String, completion : @escaping (Errors?, AccessToken?) -> Void) {
        httpHanlder.LoginPostData(authCode: authCode) { (data, error) in
            self.responseHandler.parseResponse(data, error) { (token, error) in
                completion(error,token )
            }
        }
    }
    
    func getGitHubUserProfile(accessToken: String, completion : @escaping (Errors?, GitHubUser?) -> Void) {
        httpHanlder.getGitHubUserProfile(urlString: EndPoint.GithubLogin.USERPROFILE_URL, accessToken: accessToken) { (data, error) in
            self.responseHandler.parseResponse(data, error) { (user, error) in
                completion(error,user )
            }
        }
        
    }
}
