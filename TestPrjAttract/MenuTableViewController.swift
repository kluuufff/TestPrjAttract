//
//  MenuTableViewController.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 09.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case main
    case list
    case settings
}

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true)
    }

}
