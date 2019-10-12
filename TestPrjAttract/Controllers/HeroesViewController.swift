//
//  ViewController.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 08.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

var heroes = [Heroes]()
public var nameOfHeroArray = [String](),
           timeOfHeroArray = [String](),
           descriptionOfHeroArray = [String](),
           imageOfHeroArray = [String]()

class HeroesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    public var myIndex: Int = 0
    public let transition = SlideInTransition()
    
    private var resultSearchBar = UISearchController()
    public var searchResult = [String]()
    public var searchFlag = false
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
        get()
        #endif
        
        getData(tableView: tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }

    // MARK: - prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if searchFlag {
            if  segue.identifier == "segue",
                let destination = segue.destination as? DetailViewController {
                destination.tempString = heroes[myIndex].description
            }
        } else {
            if  segue.identifier == "segue",
                let destination = segue.destination as? DetailViewController,
                let myIndex = tableView.indexPathForSelectedRow?.row {
                    destination.tempString = heroes[myIndex].description
            }
        }
    }
    
    @IBAction func openMenuAction(_ sender: UIBarButtonItem) {
        guard let menu = storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as? MenuTableViewController else { return }
        menu.didTapMenuType = { menuType in
            #if DEBUG
            print(menuType)
            #endif
            self.transitionNew(menuType)
        }
        menu.modalPresentationStyle = .overCurrentContext
        menu.transitioningDelegate = self
        present(menu, animated: true)
    }
    
}

// MARK: - get image from URL

extension UIImageView {
    //get image from URL
    func getImg(imgUrl: String) {
        let session = URLSession.shared
        if let url = URL(string: imgUrl) {
            session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "error")
                    return
                }
                DispatchQueue.main.async() {
                    self.image = UIImage(data: data!)
                }
            }.resume()
        }
    }
}

//func downloadImage(url: String) -> UIImage {
//    var image = UIImage()
//    if let url = URL(string: url) {
//        do {
//            let data = try Data(contentsOf: url)
//            DispatchQueue.main.async {
//                image = UIImage(data: data)!
//            }
//        } catch {
//            print("error")
//        }
//    }
//    return image
//}

// MARK: - TableView

extension HeroesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchFlag {
            return searchResult.count
        } else {
            return heroes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        var hero = String()
        var img = String()
        var timeAndDate = String()
        
        if searchFlag {
            hero = searchResult[indexPath.row]
            let index = nameOfHeroArray.firstIndex(of: hero)
            img = heroes[index!].image
            timeAndDate = heroes[index!].time
            myIndex = index!
        } else {
            hero = heroes[indexPath.row].name
            img = heroes[indexPath.row].image
            timeAndDate = heroes[indexPath.row].time
        }
        
        cell.nameLabel.text = "\(hero)"
//        cell.imgView!.getImg(imgUrl: img)
        cell.imgView.getImg(imgUrl: img)
        cell.dateLabel.text = "\(createDateTime(timestamp: timeAndDate))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Search

extension HeroesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResult = nameOfHeroArray.filter({$0.prefix(searchText.count) == searchText})
        searchFlag = true
        tableView.reloadData()
    }
}

// MARK: - Open/Close Menu

extension HeroesViewController: UIViewControllerTransitioningDelegate {
    
    //animation MENU when presented
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    //animation MENU when dismissed
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
    
    //transition to New view controller
    
    func transitionNew(_ menuType: MenuType) {
        
        var storyboard: UIStoryboard {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone: return UIStoryboard(name: "iPhone", bundle: nil)
            case .pad: return UIStoryboard(name: "iPad", bundle: nil)
            default:
                fatalError()
            }
        }
        
        let title = String(describing: menuType).capitalized
        switch title {
        case "List":
            if let vc = storyboard.instantiateViewController(withIdentifier: "List") as? UINavigationController {
                present(vc, animated: true, completion: nil)
            }
        case "Settings":
            if let vc = storyboard.instantiateViewController(withIdentifier: "Settings") as? UINavigationController {
                present(vc, animated: true, completion: nil)
            }
        default:
            dismiss(animated: true, completion: nil)
        }
    }
    
}
