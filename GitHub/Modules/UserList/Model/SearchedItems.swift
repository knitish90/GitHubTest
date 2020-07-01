//
//  SearchedItems.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

struct SearchedItems : Codable {
    var user : [User]
    enum CodingKeys: String, CodingKey {
        case user = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container       =   try decoder.container(keyedBy: CodingKeys.self)
        self.user           =   try container.parse(with: .user, Value: [])
    }
}


struct SearchedRepoItems : Codable {
    var repos : [Repository]
    enum CodingKeys: String, CodingKey {
        case repos = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container       =   try decoder.container(keyedBy: CodingKeys.self)
        self.repos           =   try container.parse(with: .repos, Value: [])
    }
}
