//
//  UserDetailsViewController.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

final class UserDetailsViewController: BaseViewController {

    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var joinDateLabel: UILabel!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel : UserDetailViewModelProtocol!
    var usersDetailDataSource : RepositoryTableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doBasicSetup()
        configureUserDetails()
    }
  
    private func doBasicSetup() {
        usersDetailDataSource       =   RepositoryTableDataSource(viewModel: viewModel)
        self.tableView.dataSource   =   usersDetailDataSource
        self.tableView.delegate     =   self
        self.searchBar.delegate     =   self
    }
    
    private func configureUserDetails() {
        self.view.showLoader()
        viewModel.getUserDetails()
        viewModel.didLoadingSuccess = {
            self.view.hideLoader()
            self.updateUserDetails()
            self.configureRepoList()
        }

        viewModel.didLoadingFailed = { (error) in
            self.view.hideLoader()
            self.showAlert(error?.localizedDescription)
        }
    }
    
    private func updateUserDetails() {
        guard let user = viewModel.user else {
            return
        }
        profileImageView.setImage(with: user.profileUrl)
        userNameLabel.text  =   user.name
        emailLabel.text     =   user.email
        locationLabel.text  =   user.location
        joinDateLabel.text  =   user.created_at
        followersLabel.text =   String(user.followers)
        followingLabel.text =   String(user.following)
    }

    private func configureRepoList() {
        self.view.showLoader()
        viewModel.getUserRepoList()
        viewModel.didLoadingSuccess = {
            self.view.hideLoader()
            self.tableView.reloadData()
        }
        viewModel.didLoadingFailed = { (error) in
            self.view.hideLoader()
            self.showAlert(error?.localizedDescription)
        }
    }
}

extension UserDetailsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let cellModel = viewModel.cellViewModel(for: indexPath)
        let repoGitHubURl = cellModel.repository.cloneUrl
        if UIApplication.shared.canOpenURL(URL(string: repoGitHubURl)!) {
            UIApplication.shared.open(URL(string: repoGitHubURl)!)
        }else {
            self.showAlert(Constants.NetworkError.webViewError)
        }
    }
}

extension UserDetailsViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.isSearchEnabled = true
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        
        viewModel.getSearchedRepoList(query: searchText)
        
        viewModel.didLoadingSuccess = {
            self.view.hideLoader()
            self.tableView.reloadData()
        }
        
        viewModel.didLoadingFailed = { (error) in
            self.view.hideLoader()
            self.showAlert(error?.localizedDescription)
        }
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        resetSearchSettings()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetSearchSettings()
    }
    
    func resetSearchSettings() {
        viewModel.isSearchEnabled = false
        viewModel.resetSearchData()
        self.searchBar.text = ""
        self.tableView.reloadData()
    }
    
}

extension UserDetailsViewController : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
