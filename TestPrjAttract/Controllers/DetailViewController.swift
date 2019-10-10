//
//  DetailViewController.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 09.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    public var tempString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = tempString
        
    }

}
