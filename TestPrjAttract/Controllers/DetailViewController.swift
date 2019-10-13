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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    public var tempString = ""
    let cellScaling: CGFloat = 0.6
    
    public var nameArray = nameOfHeroArray
    public var timeArray = timeOfHeroArray
    public var descriptionArray = descriptionOfHeroArray
    public var imageArray = imageOfHeroArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = tempString
        pageControl.numberOfPages = nameArray.count
        
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.size.height)
    }
    
}


