//
//  Login.swift
//  GitHub
//
//  Created by Nitish.kumar on 26/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

struct AccessToken : Codable {
    var token : String
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
    
    init(from decoder: Decoder) throws {
        let container   =   try decoder.container(keyedBy: CodingKeys.self)
        self.token       =   try container.parse(with: .token, Value: "")
    }
}

struct GitHubUser : Codable {
    var name : String
    var userId : Int
    var email : String
    var accessToken : String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case userId = "id"
        case accessToken = "accessToken"
        case email
    }
    
    init(from decoder: Decoder) throws {
        let container   =   try decoder.container(keyedBy: CodingKeys.self)
        self.name       =   try container.parse(with: .name, Value: "")
        self.userId       =   try container.parse(with: .userId, Value: -1)
        self.email       =   try container.parse(with: .email, Value: "")
        self.accessToken       =   try container.parse(with: .accessToken, Value: "")
    }
}
