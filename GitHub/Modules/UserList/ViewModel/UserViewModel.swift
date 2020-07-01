//
//  UserViewModel.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol UsersViewModelProtocol {
    var page : Int {get set}
    var didLoadingFailed : ((_ error: Errors?)->Void)? { get set }
    var didLoadingSuccess : (()->Void)? { get set }
    var isLoading:Bool{get set}
    var isSearchEnabled:Bool{get set}
    func numberOfItem()-> Int
    func cellViewModel(for indexPath: IndexPath) -> UsersCellViewModel
    func getUsers()
    func resetSearchData()
    func searchUser(queary : String)
}

final class UserViewModel : UsersViewModelProtocol {
    var page: Int = 0
    var didLoadingFailed: ((Errors?) -> Void)?
    var didLoadingSuccess: (() -> Void)?
    var service : GitHubServiceProtocol
    var tableDataSource = [UsersCellViewModel]()
    var users = [User]()
    var searchedUsers = [User]()
    var isLoading = false
    var isSearchEnabled : Bool = false
    
    init(service: GitHubServiceProtocol) {
        self.service = service
    }

    func numberOfItem()-> Int {
        isSearchEnabled ? self.searchedUsers.count : self.users.count
    }
    
    func prepareDataSource() {
        self.tableDataSource  =   isSearchEnabled ? searchedUsers.map{UsersCellViewModel(user: $0)} : users.map{UsersCellViewModel(user: $0)}
    }
    
    func cellViewModel(for indexPath: IndexPath) -> UsersCellViewModel{
        tableDataSource[indexPath.row]
    }
    
    func resetSearchData() {
        prepareDataSource()
    }
}


extension UserViewModel {
    func getUsers() {
        service.getUsers(page: String(self.page)) { (error, users) in
            DispatchQueue.main.async {
                if error == nil {
                    self.users.append(contentsOf: users)
                    self.prepareDataSource()
                    self.didLoadingSuccess?()
                }else {
                    self.didLoadingFailed?(error)
                }
            }
        }
    }
    
    func searchUser(queary : String) {
        service.getSearchedUsers(query: queary) { (error, items) in
            DispatchQueue.main.async {
                if error == nil {
                    self.searchedUsers   =  items?.user ?? []
                    self.prepareDataSource()
                    self.didLoadingSuccess?()
                }else {
                    self.didLoadingFailed?(error)
                }
            }
        }
    }
}

