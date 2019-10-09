//
//  ViewController.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 08.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var heroes = [Heroes]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.tableView.dataSource = self
    }

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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        let hero = heroes[indexPath.row].name
        
        cell.nameLabel.text = "\(hero)"

        return cell
    }

}
