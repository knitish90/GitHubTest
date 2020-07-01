//
//  UserListViewController.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

final class UserListViewController: BaseViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    private var tapperGesture : UITapGestureRecognizer!
    
    private var usersDataSource : UserTableViewDataSource!
    var viewModel : UsersViewModelProtocol!
    weak var delegate   :   UserListCoordinatorDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserViewModel(service: GitHubService(httpHandler: HTTPClient(), responseHandler: ResponseHandler()))
        
        doBasicSetUp()
        configureUsersList()
    }

    private func doBasicSetUp() {
        //tapperGesture   =   UITapGestureRecognizer(target: self, action: #selector(handlerOnScreenTouch))
        //self.view.addGestureRecognizer(tapperGesture)
        usersDataSource = UserTableViewDataSource(viewModel: viewModel)
        self.tableView.delegate     =   self
        self.tableView.dataSource   =   usersDataSource
        self.searchBar.delegate     =   self
    }
    
    private func configureUsersList() {
        self.view.showLoader()
        viewModel.getUsers()
        viewModel.didLoadingSuccess = {
            self.view.hideLoader()
            self.viewModel.isLoading = false
            self.tableView.reloadData()
        }
        
        viewModel.didLoadingFailed = { (error) in
            self.viewModel.isLoading = false
            self.view.hideLoader()
            self.showAlert(error?.localizedDescription)
        }
    }
    
    private func configureSearchUserList(query : String) {
        self.view.showLoader()
        viewModel.searchUser(queary: query)
        
        viewModel.didLoadingSuccess = {
            self.view.hideLoader()
            self.viewModel.isLoading = false
            self.tableView.reloadData()
        }
        
        viewModel.didLoadingFailed = { (error) in
            self.viewModel.isLoading = false
            self.view.hideLoader()
            self.showAlert(error?.localizedDescription)
        }
    }
    @objc private func handlerOnScreenTouch() {
        self.view.endEditing(true)
    }

}

extension UserListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let cellModel =  viewModel.cellViewModel(for: indexPath)
        delegate?.navigateToUserDetailPage(cellModel: cellModel)
    }
}

extension UserListViewController : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height) {
            if viewModel.isLoading == false, !viewModel.isSearchEnabled {
                viewModel.isLoading = true
                viewModel.page += 1
                configureUsersList()
            }
        }
    }
}

extension UserListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.isSearchEnabled = true
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            resetSearchSettings()
            return
        }
        
        configureSearchUserList(query: searchText)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        resetSearchSettings()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetSearchSettings()
    }
    
    private func resetSearchSettings() {
        viewModel.isSearchEnabled = false
        viewModel.resetSearchData()
        self.searchBar.text = ""
        self.tableView.reloadData()
    }
}
