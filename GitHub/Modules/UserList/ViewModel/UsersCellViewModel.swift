//
//  UsersCellViewModel.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol UsersCellViewModelProtocol {
    var user : User {get}
}

struct UsersCellViewModel : UsersCellViewModelProtocol {
    var user : User
    init(user : User) {
        self.user   =   user
    }
}
