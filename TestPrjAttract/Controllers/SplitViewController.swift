//
//  SplitViewController.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 11.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {
    
    public var detailViewFrame = CGRect()

    override func viewDidLoad() {
        super.viewDidLoad()

        preferredDisplayMode = .allVisible
        detailViewFrame = self.view.frame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//        detailViewFrame = self.view.frame
        #if DEBUG
        print("detailViewFrame.width \(detailViewFrame.width)")
        print("detailViewFrame.height \(detailViewFrame.height)")
        #endif
    }
}
