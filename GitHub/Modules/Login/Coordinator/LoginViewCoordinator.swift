//
//  LoginViewCoordinator.swift
//  GitHub
//
//  Created by Nitish.kumar on 26/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewCoordinatorDelegate: class {
    func navigateToUserList()
    func navigateToWebViewPage()
}



class LoginViewCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController:UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController   =   navigationController
    }
    
    func start() {
        let controller      = LoginViewController.instance()
        controller.delegate =   self
        self.navigationController.viewControllers   =   [controller]
    }
}

extension LoginViewCoordinator : LoginViewCoordinatorDelegate {
    func navigateToWebViewPage() {
        
    }
    
    func navigateToUserList() {
        let coordinator = UserListCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.childCoordinators   =   childCoordinators
        coordinator.start()
    }
}
