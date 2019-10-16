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
    public var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = tempString
        pageControl.numberOfPages = arrayOfHero.map({$0.nameOfHero}).count
        collectionView.selectItem(at: [0, index], animated: false, scrollPosition: .centeredHorizontally)
        pageControl.currentPage = index
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfHero.map({$0.nameOfHero}).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroesCollectionViewCell", for: indexPath) as! HeroesCollectionViewCell
        cell.heroName.text = arrayOfHero[indexPath.row].nameOfHero
        cell.heroDescription.text = arrayOfHero[indexPath.row].descriptionOfHero
        cell.heroDate.text = "\(createDateTime(timestamp: arrayOfHero[indexPath.row].timeOfHero))"
        cell.heroImage.contentMode = .scaleAspectFill
        cell.heroImage.clipsToBounds = true
        cell.heroImage.getImg(imgUrl: arrayOfHero[indexPath.row].imageOfHero)

        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let vc = SplitViewController()
//        switch UIDevice.current.userInterfaceIdiom {
//            case .phone: return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.size.height)
//            case .pad: return CGSize(width: vc.detailViewFrame.width, height: vc.detailViewFrame.height)
//            default: fatalError()
//        }
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.size.height)
    }
    
}


