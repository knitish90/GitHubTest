//
//  UserListTableViewCell.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var repoCountLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(cellViewModel: UsersCellViewModel) {
        nameLabel.text  =   cellViewModel.user.name
        profileImageView.setImage(with: cellViewModel.user.profileUrl)
    }
       

}
