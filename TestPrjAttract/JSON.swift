//
//  JSON.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 08.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

//import UIKit

//func getData() {
//    
//    guard let url = URL(string: "http://test.php-cd.attractgroup.com/test.json") else { return }
//    let session = URLSession.shared
//    
//    session.dataTask(with: url) { (data, _, error) in
//        guard let data = data else { return }
//        
//        let decoder = JSONDecoder()
//        
//        if let heroes = try? decoder.decode([Heroes].self, from: data) {
//            DispatchQueue.main.async {
//                self.heroes = heroes
//                print("heroes \(heroes)")
//            }
//        } else {
//            print("error")
//        }
//        }.resume()
//}

//        guard let url = URL(string: "http://test.php-cd.attractgroup.com/test.json") else { return }
//        let session = URLSession.shared
//
//        session.dataTask(with: url) { (data, _, error) in
//            guard let data = data else { return }
//            do {
//                guard let data = data else { return }
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let decoded = try decoder.decode([Heroes].self, from: data)
//                for heroName in decoded {
//                    heroes = heroName.name as! [String]
//                }
//                print(decoded)
//            } catch {
//                print(error)
//            }
//        }.resume()

//func get() {
//
//    guard let url = URL(string: "http://test.php-cd.attractgroup.com/test.json") else { return }
//
//    let session = URLSession.shared
//    session.dataTask(with: url) { (data, response, error) in
//        if let response = response {
//            print(response)
//        }
//
//        guard let data = data else { return }
//        print(data)
//
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            print(json)
//        } catch {
//            print(error)
//        }
//
//        }.resume()
//
//}
