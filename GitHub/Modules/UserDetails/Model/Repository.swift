//
//  UserRepo.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

struct Repository : Codable {
    var name : String
    var forkCount : Int
    var rating : Int
    var cloneUrl : String
    
    enum CodingKeys: String, CodingKey {
        case name
        case forkCount  =   "forks"
        case rating     =   "stargazers_count"
        case cloneUrl   =   "clone_url"
    }
    
    init(from decoder: Decoder) throws {
        let container   =   try decoder.container(keyedBy: CodingKeys.self)
        self.name       =   try container.parse(with: .name, Value: "")
        self.forkCount  =   try container.parse(with: .forkCount, Value: 0)
        self.rating     =   try container.parse(with: .rating, Value: 0)
        self.cloneUrl   =   try container.parse(with: .cloneUrl, Value: "")
    }
}
