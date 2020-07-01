//
//  UsersDataSource.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit


protocol UsersDataProtocol : UITableViewDataSource {
    init(viewModel : UsersViewModelProtocol )
}

class UserTableViewDataSource : NSObject, UITableViewDataSource {
    private let viewModel : UsersViewModelProtocol
    
    required init(viewModel: UsersViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItem()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as! UserListTableViewCell
        cell.configure(cellViewModel: viewModel.cellViewModel(for: indexPath))
           
        return cell
    }
}
