//
//  ContactDetailCoordinator.swift
//  GitHub
//
//  Created by Nitish.kumar on 26/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit


class UserDetailCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var navigationController : UINavigationController?
    var cellModel : UsersCellViewModelProtocol!
    
    required init(navigationController: UINavigationController) {
        self.navigationController   =   navigationController
    }
    
    func start() {
        let controller = UserDetailsViewController.instance()
        let viewModel = UserDetailViewModel(service: GitHubService(httpHandler: HTTPClient(), responseHandler: ResponseHandler()), userCellModel: cellModel)
        controller.viewModel    =   viewModel
        self.navigationController?.pushViewController(controller, animated: true)
    }    
}
