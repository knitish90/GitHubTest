//
//  CellHelper.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit


protocol CellBaseProtocol {
    associatedtype T
    func configure(cellViewModel : T)
}

typealias CustomBaseCell = UITableViewCell & CellBaseProtocol
