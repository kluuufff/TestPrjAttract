//
//  Data.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 08.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import Foundation
import UIKit

//JSON Data
struct Heroes: Codable {
    let name: String
    let image: String
    let time: String
    let description: String
}

//Array of Heroes
public class ListData: NSObject {
    let nameOfHero: String
    let timeOfHero: String
    let descriptionOfHero: String
    let imageOfHero: String
    
    init(nameOfHero: String, timeOfHero: String, descriptionOfHero: String, imageOfHero: String) {
        self.nameOfHero = nameOfHero
        self.timeOfHero = timeOfHero
        self.descriptionOfHero = descriptionOfHero
        self.imageOfHero = imageOfHero
    }
}

