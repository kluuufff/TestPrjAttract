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
        
//        let json: String = """
//            [
//            {"name": "Name"},
//            {"time": "01-март-2016 10:10"}
//            ]
//            """
        session.dataTask(with: url) { (data, _, error) in
//            let jsonString = "{\"time\":\"01-марта-2016 10:10\"}"
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
//                let formatter = DateFormatter()
//                formatter.dateFormat = "dd-MM-yyyy HH:mm"
//                decoder.dateDecodingStrategy = .formatted(formatter)

//                decoder.dateDecodingStrategy = .formatted(formatter)
//                decoder.dateDecodingStrategy = .formatted(.dateFormatter)
//                self.heroes = try decoder.decode([Heroes].self, from: json.data(using: .utf8)!)
                self.heroes = try decoder.decode([Heroes].self, from: data)

                print("from getData \(self.heroes)")
                
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
//        let img = heroes[indexPath.row].image
        let date = heroes[indexPath.row].time
        
        cell.nameLabel.text = "\(hero)"
//        cell.imageView?.image = UIImage(NSURL(string: img))
        cell.dateLabel.text = "\(date)"
        
        print("from cellForRowAt \(hero)")
        print("from cellForRowAt \(date)")

        return cell
    }

}

//extension DateFormatter {
//    static let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy"
//        return formatter
//    }()
//}
