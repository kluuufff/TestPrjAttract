//
//  Functions.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 09.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

//get image from URL
func getImg(imgUrl: String) -> UIImage {
    
    var img: UIImage!
    if let url = URL(string: imgUrl) {
        do {
            let data = try Data(contentsOf: url)
            img = UIImage(data: data)
        } catch {
            print("error")
        }
    }
    return img
    
}
