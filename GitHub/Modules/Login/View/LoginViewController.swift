//
//  LoginViewController.swift
//  GitHub
//
//  Created by Nitish.kumar on 26/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

final class LoginViewController: BaseViewController {

    weak var delegate : LoginViewCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginWithGitHub(_ sender: Any) {
        let viewModel = LoginViewModel(service: LoginService(httpHanlder: HTTPClient(), responseHandler: ResponseHandler()), webURl: EndPoint.GithubLogin.loginURl)
        let instance = WebViewController.instance()
        instance.viewModel =   viewModel
        self.present(instance, animated: true, completion: nil)
    }
    
    @IBAction func proceedAsGuest(_ sender: Any) {
        delegate?.navigateToUserList()
    }
    
}
