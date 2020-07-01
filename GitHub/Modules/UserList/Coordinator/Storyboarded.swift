//
//  Storyboarded.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//


import Foundation
import UIKit

protocol StoryboardProtocol {
    static func instance() -> Self
}


extension StoryboardProtocol where Self: UIViewController {
    static func instance() -> Self{
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}



