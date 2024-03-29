//
//  JSON.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 08.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

public var arrayOfHero: [ListData] = [ListData]()

//parsing JSON
func getData(tableView: UITableView) {
    
    guard let url = URL(string: "http://test.php-cd.attractgroup.com/test.json") else { return }
    let session = URLSession.shared
    

    session.dataTask(with: url) { (data, _, error) in
        guard let data = data else { return }
        do {
            //decode
            let decoder = JSONDecoder()
            heroes = try decoder.decode([Heroes].self, from: data)
            
            //hero array for search
            var getHero: ListData
            for i in 0..<heroes.count {
                getHero = ListData(nameOfHero: heroes[i].name, timeOfHero: heroes[i].time, descriptionOfHero: heroes[i].description, imageOfHero: heroes[i].image)
                arrayOfHero.append(getHero)
                
                #if DEBUG
                print("arrayOfHero: \(arrayOfHero[i].nameOfHero)")
                #endif
                
            }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {
            print(error)
        }
    }.resume()
}

// MARK: - convert "time"

func createDateTime(timestamp: String) -> String {
    var strDate = ""
    
    if let unixTime = Double(timestamp) {
        let date = Date(timeIntervalSince1970: unixTime / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_UA")
        dateFormatter.dateFormat = "dd-MMMM-yyyy HH:mm"
        strDate = dateFormatter.string(from: date)
    }
    
    return strDate
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
