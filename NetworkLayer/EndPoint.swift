//
//  EndPoint.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation


struct EndPoint {
    static let baseURL = "https://api.github.com/"
    
    struct Users {
        static let userList      =   EndPoint.baseURL + "users?since={page}&per_page=15"
        static let searchUsers   =   EndPoint.baseURL + "search/users?q={query}"
        static let searchRepositories =   EndPoint.baseURL + "search/repositories?q={query}"
    }
    
    struct GithubLogin {
        static let USERPROFILE_URL  =   "https://api.github.com/user"
        static let CLIENT_ID        =   "3bbcd56ef26e156fdf0f"
        static let CLIENT_SECRET    =   "d94b52a66881365a30fea05bfb86f61009fa6819"
        static let REDIRECT_URI     =   "https://github.com/"
        static let SCOPE            =   "read:user,user:email"
        static let TOKENURL         =   "https://github.com/login/oauth/access_token"
        static let uuid             =   UUID().uuidString
        static let loginURl         =   "https://github.com/login/oauth/authorize?client_id=" + GithubLogin.CLIENT_ID + "&scope=" + GithubLogin.SCOPE + "&redirect_uri=" + GithubLogin.REDIRECT_URI + "&state=" + uuid
    }
}

