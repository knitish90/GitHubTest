//
//  Constants.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct ValidationError {
        static let invalidEmailError    =   "please enter valid email."
        static let invalidPhoneError    =   "please enter valid phone number."
        static let firstNameEmptyError  =   "please enter your first name."
        static let lastNameEmptyError   =   "please enter your last name."
    }
    struct Colors {
        static let appStandardColor     =   UIColor(red: 200.0/255.0, green: 227.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        static let headerColor     =   UIColor(red: 180.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    }
    
    struct NetworkError {
        static let inValidURLError      =   "URL is not valid."
        static let internetConnectionError   =   "you are offline, please connect to the internet."
        static let genericError         =   "something went wrong, please try after some time."
        static let webViewError         =   "Sorry, URL can't be opened"
    }
    
    struct DateFormat {
        static let serverDateFormat     =   "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }
    
    struct GitHubUser {
        static let userName =   "kUserName"
        static let userId   =   "kUserId"
        static let accessToken = "kAccessToken"
        static let email    = "kEmail"
    }
}
