//
//  File.swift
//  PocketKitchen
//
//  Created by Miguel Batilando on 7/17/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecipeListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getRecipeData(food: [String]) {
        
        let foodVar = food.joined(separator: "+")
//        var foodArray = ["chicken", "cheese"]
//        var foodVar = "chicken"
        let apiToContact = "http://api.edamam.com/search?q=\(foodVar)&app_id=58964742&app_key=af5da5d1d5d239130b3a195bd566f6cd"
        
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var index = 0
                    for food in json {
                        print(json["hits"][index]["recipe"]["label"].stringValue)
                        print(json["hits"][index]["recipe"]["ingredientLines"])
                        print(json["hits"][index]["recipe"]["url"].stringValue)
                        print(json["hits"][index]["recipe"]["image"].stringValue)
                        index = index + 1
                        print("index: \(index)")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
