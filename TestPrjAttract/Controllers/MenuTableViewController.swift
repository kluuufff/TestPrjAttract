//
//  MenuTableViewController.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 10.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case main
    case list
    case settings
}

class MenuTableViewController: UITableViewController {
    
    public var didTapMenuType: ((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            if tableView.numberOfSections == 2 {
                #if DEBUG
                print("Dismissing: \(menuType)")
                #endif
                self?.didTapMenuType?(menuType)
            }
        }
    }
    
}
