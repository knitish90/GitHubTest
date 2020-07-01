//
//  User.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol UserDataBaseProtocol {
    var id : Int {get}
    var name : String {get}
    var profileUrl : String {get}
    var url : String {get}
    var followersUrl : String {get}
    var repoListUrl : String {get}
    var email : String {get}
    var created_at : String {get}
    var updated_at : String {get}
    var followers : Int {get}
    var following : Int {get}
    var location : String {get}
}


struct User : Codable, UserDataBaseProtocol{
    var id : Int
    var name : String
    var profileUrl : String
    var url : String
    var followersUrl : String
    var repoListUrl : String
    var email : String
    var created_at : String
    var updated_at : String
    var followers : Int
    var following : Int
    var location : String
    
    enum CodingKeys: String, CodingKey {
        case id, url, email, created_at, updated_at, following, followers, location
        case name           =   "login"
        case profileUrl     =   "avatar_url"
        case followersUrl   =   "followers_url"
        case repoListUrl    =   "repos_url"
    }
    
    init(from decoder: Decoder) throws {
        let container       =   try decoder.container(keyedBy: CodingKeys.self)
        self.id             =   try container.parse(with: .id, Value: 0)
        self.name           =   try container.parse(with: .name, Value: "")
        self.profileUrl     =   try container.parse(with: .profileUrl, Value: "")
        self.url            =   try container.parse(with: .url, Value: "")
        self.followersUrl   =   try container.parse(with: .followersUrl, Value: "")
        self.repoListUrl    =   try container.parse(with: .repoListUrl, Value: "")
        self.email          =   try container.parse(with: .email, Value: "")
        self.created_at     =   try container.parse(with: .created_at, Value: "")
        self.updated_at     =   try container.parse(with: .updated_at, Value: "")
        self.followers      =   try container.parse(with: .followers, Value: 0)
        self.following      =   try container.parse(with: .following, Value: 0)
        self.location       =   try container.parse(with: .location, Value: "")
    }
}

extension KeyedDecodingContainer {
    func parse<T>(with key: K, Value: T) throws -> T where T : Decodable {
            return try decodeIfPresent(T.self, forKey: key) ?? Value
    }
}

