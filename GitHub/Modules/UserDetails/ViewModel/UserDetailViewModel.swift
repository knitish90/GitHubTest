//
//  UserDetailViewModel.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol UserDetailViewModelProtocol {
    var didLoadingFailed : ((_ error : Error?) -> Void)? { get set}
    var didLoadingSuccess : (()-> Void)? { get set}
    var user : User? {get}
    var userCellModel : UsersCellViewModelProtocol { get set}
    var isSearchEnabled : Bool { get set}
    func numberOfItem()-> Int
    func getUserDetails()
    func getUserRepoList()
    func resetSearchData()
    func getSearchedRepoList(query : String)
    func cellViewModel(for indexPath: IndexPath) -> RepositoriesCellViewModel
}

final class UserDetailViewModel: UserDetailViewModelProtocol {
    var didLoadingFailed: ((Error?) -> Void)?
    var didLoadingSuccess: (() -> Void)?
    var service : GitHubServiceProtocol
    var user : User?
    var userCellModel : UsersCellViewModelProtocol
    var isSearchEnabled = false
    var repositories = [Repository]()
    var searchedRepositories = [Repository]()
    var tableDataSource = [RepositoriesCellViewModel]()
    
    init(service: GitHubServiceProtocol, userCellModel : UsersCellViewModelProtocol) {
        self.service = service
        self.userCellModel   =   userCellModel
    }
    
    func numberOfItem()-> Int {
        isSearchEnabled ? self.searchedRepositories.count : self.repositories.count
    }
    
    func prepareDataSource() {
        self.tableDataSource    =   isSearchEnabled ? searchedRepositories.map{RepositoriesCellViewModel(repository: $0)} : repositories.map{RepositoriesCellViewModel(repository: $0)}
    }
    
    func cellViewModel(for indexPath: IndexPath) -> RepositoriesCellViewModel{
        tableDataSource[indexPath.row]
    }
    
    func resetSearchData() {
        prepareDataSource()
    }
    
    func getUserDetails() {
        let uerDetailsUrl = userCellModel.user.url
        service.getUserDetails(userUrl: uerDetailsUrl) { (error, user) in
            DispatchQueue.main.async {
                if error == nil {
                    self.user   =   user
                    self.didLoadingSuccess?()
                }else {
                    self.didLoadingFailed?(error)
                }
            }
        }
    }
    
    func getUserRepoList() {
        let repoUrl =   userCellModel.user.repoListUrl
        service.getUserRepoList(repoListUrl: repoUrl) { (error, repoList) in
            DispatchQueue.main.async {
                if error == nil {
                    self.repositories   =   repoList ?? []
                    self.prepareDataSource()
                    self.didLoadingSuccess?()
                }else {
                    self.didLoadingFailed?(error)
                }
            }
        }
    }
    
    func getSearchedRepoList(query : String) {
        service.getSearchedRepository(query: query) { (error, items) in
            DispatchQueue.main.async {
                if error == nil {
                    self.searchedRepositories   =   items?.repos ?? []
                    self.prepareDataSource()
                    self.didLoadingSuccess?()
                }else {
                    self.didLoadingFailed?(error)
                }
            }
        }
    }
}
