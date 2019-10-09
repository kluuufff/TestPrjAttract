//
//  ViewController.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 08.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

var descr = [String]()
//var myIndex = 0

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var heroes = [Heroes]()

    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    // MARK: - parse JSON
    
    func getData() {
        guard let url = URL(string: "http://test.php-cd.attractgroup.com/test.json") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                self.heroes = try decoder.decode([Heroes].self, from: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - get image
    
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
        cell.imgView.image = self.getImg(imgUrl: img)
        cell.dateLabel.text = "\(timeAndDate)"

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "segue",
            let destination = segue.destination as? DetailViewController,
            let myIndex = tableView.indexPathForSelectedRow?.row {
            destination.tempString = heroes[myIndex].description
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
