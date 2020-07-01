//
//  ContactListCoordinator.swift
//  GitHub
//
//  Created by Nitish.kumar on 26/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//
import Foundation
import UIKit


protocol Coordinator : class {
    var childCoordinators : [Coordinator] { get set }
    init(navigationController : UINavigationController)
    func start()
}

protocol UserListCoordinatorDelegate: class {
    func navigateToUserDetailPage(cellModel : UsersCellViewModelProtocol)
}



class UserListCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController:UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController   =   navigationController
    }
    
    func start() {
        let controller = UserListViewController.instance()
        controller.delegate =   self
        controller.viewModel    =  UserViewModel(service: GitHubService(httpHandler: HTTPClient(), responseHandler: ResponseHandler()))
        self.navigationController.viewControllers   =   [controller]
        //((UIApplication.shared.delegate) as? SceneDelegate)?.window?.rootViewController = self.navigationController
    }
}



extension UserListCoordinator : UserListCoordinatorDelegate {
    func navigateToUserDetailPage(cellModel: UsersCellViewModelProtocol) {
        let coordinator = UserDetailCoordinator(navigationController: navigationController)
        coordinator.cellModel = cellModel
        childCoordinators.append(coordinator)
        coordinator.childCoordinators   =   childCoordinators
        coordinator.start()
    }
}

