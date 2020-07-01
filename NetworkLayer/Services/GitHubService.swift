//
//  GitHubService.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol GitHubServiceProtocol {
    func getUsers(page: String, completion : @escaping (Errors?, [User]) -> Void)
    func getSearchedUsers(query:String, completion : @escaping (Errors?, SearchedItems?) -> Void)
    func getUserDetails(userUrl: String, completion: @escaping (Errors?, User?) -> Void)
    func getUserRepoList(repoListUrl: String, completion: @escaping (Errors?, [Repository]?) -> Void)
    func getSearchedRepository(query:String, completion : @escaping (Errors?, SearchedRepoItems?) -> Void)
}


class GitHubService : GitHubServiceProtocol{
    var httpHandler : HTTPClient
    var responseHandler : ResponseHandler
    init(httpHandler : HTTPClient, responseHandler : ResponseHandler) {
        self.httpHandler    =   httpHandler
        self.responseHandler    =   responseHandler
    }
    func getUsers(page: String, completion: @escaping (Errors?, [User]) -> Void) {
        let urlString = EndPoint.Users.userList
        let modifiedUrl = urlString.replace(of: "{page}", with: page)
        httpHandler.getData(urlString: modifiedUrl) { (data, error) in
            self.responseHandler.parseResponse(data, error) { (list, error) in
                completion(error,list ?? [])
            }
        }
    }
    
    func getSearchedUsers(query:String, completion : @escaping (Errors?, SearchedItems?) -> Void) {
        let urlString = EndPoint.Users.searchUsers
        let modifiedUrl = urlString.replace(of: "{query}", with: query)
        httpHandler.getData(urlString: modifiedUrl) { (data, error) in
            self.responseHandler.parseResponse(data, error) { (list, error) in
                completion(error,list )
            }
        }
    }
    
    func getUserDetails(userUrl: String, completion: @escaping (Errors?, User?) -> Void) {
        httpHandler.getData(urlString: userUrl) { (data, error) in
            self.responseHandler.parseResponse(data, error) { (list, error) in
                completion(error,list )
            }
        }
    }
    
    func getUserRepoList(repoListUrl: String, completion: @escaping (Errors?, [Repository]?) -> Void)  {
        httpHandler.getData(urlString: repoListUrl) { (data, error) in
            self.responseHandler.parseResponse(data, error) { (list, error) in
                completion(error,list )
            }
        }
    }
    
    func getSearchedRepository(query:String, completion : @escaping (Errors?, SearchedRepoItems?) -> Void) {
        let urlString = EndPoint.Users.searchRepositories
        let modifiedUrl = urlString.replace(of: "{query}", with: query)
        httpHandler.getData(urlString: modifiedUrl) { (data, error) in
            self.responseHandler.parseResponse(data, error) { (items, error) in
                completion(error,items )
            }
        }
    }
}
