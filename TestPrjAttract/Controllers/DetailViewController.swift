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
    
    public var nameArray = nameOfHeroArray
    public var timeArray = timeOfHeroArray
    public var descriptionArray = descriptionOfHeroArray
    public var imageArray = imageOfHeroArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = tempString
        
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroesCollectionViewCell", for: indexPath) as! HeroesCollectionViewCell
        
        cell.heroName.text = nameArray[indexPath.row]
        cell.heroDescription.text = descriptionArray[indexPath.row]
        cell.heroDate.text = "\(createDateTime(timestamp: timeArray[indexPath.row]))"
        cell.heroImage.contentMode = .scaleAspectFill
        cell.heroImage.clipsToBounds = true
        cell.heroImage.getImg(imgUrl: imageArray[indexPath.row])
        
        return cell
    }
    
}
