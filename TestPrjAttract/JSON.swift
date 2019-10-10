//
//  JSON.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 08.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//



import UIKit

//parsing JSON
func getData(tableView: UITableView) {
    
    guard let url = URL(string: "http://test.php-cd.attractgroup.com/test.json") else { return }
    let session = URLSession.shared
    
    session.dataTask(with: url) { (data, _, error) in
        guard let data = data else { return }
        do {
            let decoder = JSONDecoder()
            heroes = try decoder.decode([Heroes].self, from: data)
            
            heroArray = [String]()
            for i in 0..<heroes.count {
                heroArray.append(heroes[i].name)
            }
            print(heroArray)
            
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {
            print(error)
        }
    }.resume()
}


#if DEBUG

func get() {

    guard let url = URL(string: "http://test.php-cd.attractgroup.com/test.json") else { return }

    let session = URLSession.shared
    session.dataTask(with: url) { (data, response, error) in
        if let response = response {
            print(response)
        }

        guard let data = data else { return }
        print(data)

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        } catch {
            print(error)
        }

        }.resume()

}

#endif
