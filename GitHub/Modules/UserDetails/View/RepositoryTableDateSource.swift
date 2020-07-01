//
//  RepositoryTableDateSource.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

protocol UsersDetailDataSourceProtocol : UITableViewDataSource {
    init(viewModel : UserDetailViewModelProtocol )
}

class RepositoryTableDataSource : NSObject, UITableViewDataSource {
    private let viewModel : UserDetailViewModelProtocol
    
    required init(viewModel: UserDetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItem()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoriesListViewCell") as! RepositoriesListViewCell
        cell.configure(cellViewModel: viewModel.cellViewModel(for: indexPath))
           
        return cell
    }
}

