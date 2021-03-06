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
import AlamofireImage

class RecipeListViewController: UITableViewController {
    
    @IBOutlet var recipeTableView: UITableView!
    
    var finalIngredientList = [String]()
    var displayRecipesList = [RecipeModel]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipeData(food: finalIngredientList, completionHandler: handleRecipeModelData)
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
                        let ingredients = json["hits"][index]["recipe"]["ingredientLines"].arrayObject
                        let imageURL = json["hits"][index]["recipe"]["image"].stringValue
                        var ingredientStr = ""
                        for ingredient in ingredients! {
                            ingredientStr += ingredient as! String + ", "
                        }
                        let image = json["hits"][index]["recipe"]["image"].stringValue
                        let directions = json["hits"][index]["recipe"]["url"].stringValue
                        let calories = json["hits"][index+1]["recipe"]["calories"].int32Value
                        var recipe = RecipeModel(name: recipeName, ingredients: ingredientStr, foodImage: image, directions: directions, calories: calories, imageUrl: image)
                        index = index + 1
                        recipeResults.append(recipe)
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
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return displayRecipesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        let recipe = displayRecipesList[indexPath.row]
        let imageURL = recipe.imageUrl
        cell.recipeTitleLabel.text = recipe.name
        let calorieStr = String(recipe.calories) + " calories"
        cell.recipeCalorieLabel.text = calorieStr
        Alamofire.request(imageURL).responseImage { response in
            if let image = response.result.value {
                self.displayRecipesList[indexPath.row].recipeUIImage = image
                cell.foodImage.image = image
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "displayRecipe" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recipe = displayRecipesList[indexPath.row]
            
            let recipeCoreData = createCoreDataObject(recipeModel: recipe)
            
            let destination = segue.destination as! DisplayRecipeViewController
            destination.recipe = recipeCoreData
        }
    }
    
    func createCoreDataObject(recipeModel: RecipeModel) -> Recipe {
        
        //Creates CoreDataModel
        let object = CoreDataHelper.newRecipe()
        object.setValue(recipeModel.name, forKey: "name")
        object.setValue(recipeModel.ingredients, forKey: "ingredients")
        object.setValue(recipeModel.directions, forKey: "directions")
        object.setValue(recipeModel.calories, forKey: "calories")
        object.setValue("yes", forKey: "isClicked")
        object.setValue(recipeModel.imageUrl, forKey: "imageUrl")
        
        //Save CoreDataModel
        CoreDataHelper.saveRecipe()
        
        return object
    }

}
