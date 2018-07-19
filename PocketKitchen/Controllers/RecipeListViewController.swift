//
//  RecipeListViewController.swift
//  PocketKitchen
//
//  Created by Miguel Batilando on 7/17/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecipeListViewController: UITableViewController {
    
    var finalIngredientList = [String]()
    var recipeTitle = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("finalIngredientList: \(finalIngredientList)")
        getRecipeData(food: finalIngredientList)
        print(recipeTitle)
        
    }
    
    func getRecipeData(food: [String]) {
        
        let foodVar = food.joined(separator: "+")
        let apiToContact = "http://api.edamam.com/search?q=\(foodVar)&app_id=58964742&app_key=af5da5d1d5d239130b3a195bd566f6cd"
        
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var index = 0
                    for food in json {
                        // recipe title
                        print(json["hits"][index]["recipe"]["label"].stringValue)
                        self.recipeTitle.append(json["hits"][index]["recipe"]["label"].stringValue)
                        // recipe ingredient lines
                       // print(json["hits"][index]["recipe"]["ingredientLines"])
                        // recipe directions url
                       // print(json["hits"][index]["recipe"]["url"].stringValue)
                        // recipe image url
                        //print(json["hits"][index]["recipe"]["image"].stringValue)
                        index = index + 1
                        print("index: \(index)")
                        //print("recipeTitleArray: \(self.recipeTitle)")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return finalIngredientList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        cell.recipeTitleLabel.text = finalIngredientList[indexPath.row]
        return cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell", for: indexPath) as! RecipeTableViewCell
//
//        let recipe = recipesClicked[indexPath.row]
//        cell.recipeTitleLabel.text = recipe.name
    }
    
}
