//
//  WebViewController.swift
//  GitHub
//
//  Created by Nitish.kumar on 26/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController {

    @IBOutlet weak var webView: WKWebView!
    var viewModel : LoginViewModelProtocol!
    weak var delegate : WebViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        doBasicSetup()
        loadWebUrl()
    }
    
    private func doBasicSetup() {
        webView.navigationDelegate  =   self
    }

    @IBAction private func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private func loadWebUrl() {
        guard let url = URL(string: viewModel.webURl) else {
            return
        }
        self.view.showLoader()
        webView.load(URLRequest(url: url))
    }
}

extension WebViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.view.hideLoader()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        viewModel.getAuthCode(request: navigationAction.request)
        viewModel.reuestForGithubAccessToken { (token) in
            if token.isEmpty == false {
                self.viewModel.getGitHubUserProfile(token: token) {
                    self.viewModel.saveLoggedInUserDetails()
                    self.dismiss(animated: true) 
                }
            }
        }
        decisionHandler(.allow)
    }
}
