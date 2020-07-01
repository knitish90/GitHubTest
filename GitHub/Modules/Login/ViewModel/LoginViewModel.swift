//
//  LoginViewModel.swift
//  GitHub
//
//  Created by Nitish.kumar on 01/07/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol LoginViewModelProtocol {
    var webURl : String {get set}
    func getAuthCode(request: URLRequest)
    func reuestForGithubAccessToken( completion : @escaping (_ token : String)->Void)
    func getGitHubUserProfile(token : String, completion :@escaping ()->Void)
    func saveLoggedInUserDetails()
}

final class LoginViewModel :LoginViewModelProtocol{
   
    
   
    var service : LoginServiceProtocol
    var webURl : String
    var authCode : String = ""
    var gitHubUser : GitHubUser?
    
    init(service : LoginServiceProtocol, webURl : String) {
        self.service    =   service
        self.webURl =   webURl
    }
    
    func getAuthCode(request: URLRequest) {
        guard let requestURLString = request.url?.absoluteString else {
            return
        }
        
        if requestURLString.hasPrefix(EndPoint.GithubLogin.REDIRECT_URI) {
            if requestURLString.contains("code=") {
                if let range = requestURLString.range(of: "=") {
                    let githubCode = requestURLString[range.upperBound...]
                    if let range = githubCode.range(of: "&state=") {
                        self.authCode = String(githubCode[..<range.lowerBound])
                    }
                }
            }
        }
    }
    
    func reuestForGithubAccessToken(completion:@escaping (String) -> Void) {
        service.getGithubAccessToken(authCode: self.authCode) { (error, token) in
            DispatchQueue.main.async {
                completion(token?.token ?? "")
            }
        }
    }
    
    func getGitHubUserProfile(token: String, completion: @escaping () -> Void) {
        service.getGitHubUserProfile(accessToken: token) { (error, gitHubUser) in
            DispatchQueue.main.async {
                self.gitHubUser = gitHubUser
                completion()
            }
        }
    }
    
    func saveLoggedInUserDetails() {
        let defaults = UserDefaults.standard
        defaults.set(gitHubUser?.name, forKey: "userName")
        defaults.set(gitHubUser?.userId, forKey: "userId")
    }
}
