//
//  SceneDelegate.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

typealias responseComletion<T> = (_ object : T?, _ error : Errors?)->Void

protocol ResponseProtocol {
    func  parseResponse <T : Codable> (_ data : Data?,_ error : Errors?, _ completion : responseComletion<T>)
}


struct ResponseHandler : ResponseProtocol {
    func parseResponse<T>(_ data: Data?, _ error: Errors?, _ completion: (T?, Errors?) -> Void) where T : Codable {
        
        if error == nil {
            do {
                guard let data = data else {
                    return completion(nil, Errors(message: Constants.NetworkError.inValidURLError))
                }
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(response, nil)
            } catch let error  {
                completion(nil, Errors(message: error.localizedDescription))
            }
        }else {
            completion(nil, error)
        }
    }
}
