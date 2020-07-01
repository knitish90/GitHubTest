//
//  RepositoriesCellViewModel.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol  RepositoriesCellViewModelProtocol  {
    
}

class RepositoriesCellViewModel : RepositoriesCellViewModelProtocol{
    var repository : Repository
    
    init(repository : Repository) {
        self.repository = repository
    }
}
