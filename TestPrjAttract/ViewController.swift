//
//  ViewController.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 08.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

var heroes = [Heroes]()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let transition = SlideInTransition()
    
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

    // MARK: - numberOfRowsInSection
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    // MARK: - cellForRowAt

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        let hero = heroes[indexPath.row].name
        let img = heroes[indexPath.row].image
        let timeAndDate = heroes[indexPath.row].time
        
        cell.nameLabel.text = "\(hero)"
        cell.imgView.image = getImg(imgUrl: img)
        cell.dateLabel.text = "\(timeAndDate)"

        return cell
    }
    
    // MARK: - prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "segue",
            let destination = segue.destination as? DetailViewController,
            let myIndex = tableView.indexPathForSelectedRow?.row {
            destination.tempString = heroes[myIndex].description
        }
    }
    
    // MARK: - didSelectRowAt
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func openMenuAction(_ sender: UIBarButtonItem) {
        guard let menu = storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") else { return }
        menu.modalPresentationStyle = .overCurrentContext
        menu.transitioningDelegate = self
        present(menu, animated: true)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
    
}
