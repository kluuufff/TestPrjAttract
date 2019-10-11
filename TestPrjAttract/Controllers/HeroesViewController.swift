//
//  ViewController.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 08.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

var heroes = [Heroes]()
var heroArray = [String]()

class HeroesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let transition = SlideInTransition()
    
    var searchResult = [String]()
    var searchFlag = false
    
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
        if  segue.identifier == "segue",
            let destination = segue.destination as? DetailViewController,
            let myIndex = tableView.indexPathForSelectedRow?.row {
            destination.tempString = heroes[myIndex].description
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

// MARK: - TableView

extension HeroesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchFlag {
            return searchResult.count
        } else {
            return heroes.count
        }
    }
    
    func createDateTime(timestamp: String) -> String {
        var strDate = "undefined"
        
        if let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime / 1000)
            let dateFormatter = DateFormatter()
//            let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
//            dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
//            dateFormatter.locale = NSLocale.current
//            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            dateFormatter.locale = Locale(identifier: "ru_UA")
            dateFormatter.dateFormat = "dd-MMMM-yyyy HH:mm" //Specify your format that you want
            strDate = dateFormatter.string(from: date)
        }
        
        return strDate
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        var hero = String()
        var img = String()
        var timeAndDate = String()
//        var timeAndDateResult = String()
        
        if searchFlag {
            hero = searchResult[indexPath.row]
            let index = heroArray.firstIndex(of: hero)
            img = heroes[index!].image
            timeAndDate = heroes[index!].time
        } else {
            hero = heroes[indexPath.row].name
            img = heroes[indexPath.row].image
            timeAndDate = heroes[indexPath.row].time
        }
        
//        if let time = Double(timeAndDate) {
//            let timeResult = time / 1000.0
//            timeAndDateResult = String(timeResult)
//            print("Double \(timeResult)")
//        } else { print("error") }
        
        cell.nameLabel.text = "\(hero)"
        cell.imgView!.getImg(imgUrl: img)
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
        searchResult = heroArray.filter({$0.prefix(searchText.count) == searchText})
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
