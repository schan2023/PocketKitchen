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

class RecipeListViewController: UITableViewController {
    
    var finalIngredientList = [String]()
    var displayRecipesList = [RecipeModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRecipeData(food: ["chicken", "cheese"], completionHandler: handleRecipeModelData)
    }
    
    func getRecipeData(food: [String], completionHandler: @escaping ([RecipeModel]) -> Void) {
        
        var recipeResults: [RecipeModel] = []
        
        let foodVar = food.joined(separator: "+")
        let apiToContact = "http://api.edamam.com/search?q=\(foodVar)&app_id=58964742&app_key=af5da5d1d5d239130b3a195bd566f6cd"
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var index = 0
                    for food in json {
                        let recipeName = json["hits"][index]["recipe"]["label"].stringValue
                        let ingredients = json["hits"][index]["recipe"]["ingredientLines"].stringValue
                        let recipe = RecipeModel(name: recipeName, ingredients: [ingredients])
                        
//                        print(json["hits"][index]["recipe"]["label"].stringValue)
//                        print(json["hits"][index]["recipe"]["ingredientLines"])
//                        print(json["hits"][index]["recipe"]["url"].stringValue)
//                        print(json["hits"][index]["recipe"]["image"].stringValue)
                        index = index + 1
//                        print("index: \(index)")
                        
                        recipeResults.append(recipe)
//                        print(recipeResults)
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
            
             completionHandler(recipeResults)
        }
    }
    
    func handleRecipeModelData(recipesList: [RecipeModel]) -> Void {
        displayRecipesList = recipesList
        //print(displayRecipesList)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return displayRecipesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        
        let recipe = displayRecipesList[indexPath.row]
        cell.recipeTitleLabel.text = recipe.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "displayRecipe" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recipe = displayRecipesList[indexPath.row]
            let destination = segue.destination as! DisplayRecipeViewController
            destination.recipeModel = recipe //var note: Note?
            print(recipe)
            //Records if recipe was clicked
            //            CoreDataHelper.saveRecipe()
            //Check for duplicates in array before appending
            //            recipesClicked.append(recipe)
        }
    }
}
