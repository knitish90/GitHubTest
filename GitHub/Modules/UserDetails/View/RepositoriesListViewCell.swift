//
//  RepositoriesListViewCell.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class RepositoriesListViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(cellViewModel: RepositoriesCellViewModel) {
        nameLabel.text      =   cellViewModel.repository.name.capitalized
        forkCountLabel.text =   "\(cellViewModel.repository.forkCount) Forks"
        ratingLabel.text    =   "\(cellViewModel.repository.rating) Stars"
    }

}
