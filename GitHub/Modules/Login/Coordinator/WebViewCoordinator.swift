//
//  WebViewCoordinator.swift
//  GitHub
//
//  Created by Nitish.kumar on 26/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

protocol WebViewControllerDelegate : class {
    func moveToUserListPage()
}

class WebViewCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController:UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController   =   navigationController
    }
    
    func start() {
        let controller      =   WebViewController.instance()
        controller.delegate =   self
        self.navigationController.pushViewController(controller, animated: true)
    }
}

extension WebViewCoordinator : WebViewControllerDelegate {
    func moveToUserListPage() {
        let coordinator = UserListCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.childCoordinators   =   childCoordinators
        coordinator.start()
    }
    
    
}
