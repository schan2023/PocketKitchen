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
    var urlImageArray = [String]()
    
    var finalIngredientList = [String]()
    var displayRecipesList = [RecipeModel]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("finalIngredientList: \(finalIngredientList)")
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
                        let ingredients = json["hits"][index]["recipe"]["ingredientLines"].stringValue
                        let directionsURL = json["hits"][index]["recipe"]["url"].stringValue
                        let imageURL = json["hits"][index]["recipe"]["image"].stringValue
                        self.urlImageArray.append(imageURL)
                        //let recipe = RecipeModel(name: recipeName, ingredients: [ingredients], foodImage: String, directions: String)
                        let recipe = RecipeModel(name: recipeName, ingredients: [ingredients], foodImage: imageURL, directions: directionsURL)
//                        print(json["hits"][index]["recipe"]["label"].stringValue)
//                        print(json["hits"][index]["recipe"]["ingredientLines"])
//                        print(json["hits"][index]["recipe"]["url"].stringValue)
//                        print(json["hits"][index]["recipe"]["image"].stringValue)
                        index = index + 1
//                        print("index: \(index)")
                        
                        recipeResults.append(recipe)
//                        print(recipeResults)
                        
//                        let imagesArray: NSArray = json as! NSArray
//
//                        for i in 0..<imagesArray.count {
//                            self.displayRecipesList.append(RecipeModel(
//                                name: (imagesArray[i] as AnyObject).value(forKey: "name") as! String, ingredients: (imagesArray[i] as AnyObject).value(forKey: "ingredients") as! [String], foodImage: (imagesArray[i] as AnyObject).value(forKey: "foodImage") as! String, directions: (imagesArray[i] as AnyObject).value(forKey: "name") as! String))
//                        }
                    }
//                    self.recipeTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
             completionHandler(recipeResults)
        }
    }
    
    func handleRecipeModelData(recipesList: [RecipeModel]) -> Void {
        displayRecipesList = recipesList
        print(urlImageArray)
        //print(displayRecipesList)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return displayRecipesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        let recipe = displayRecipesList[indexPath.row]
        let imageURL = urlImageArray[indexPath.row]
        cell.recipeTitleLabel.text = recipe.name
        
        // "https://httpbin.org/image/png"
        Alamofire.request(imageURL).responseImage { response in
            if let image = response.result.value {
                print("image downloaded: \(image)")
                cell.foodImage.image = image
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "displayRecipe" {
            
            print("Going into displayRecipe segue")
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recipe = displayRecipesList[indexPath.row]
            let destination = segue.destination as! DisplayRecipeViewController
            destination.recipe = recipe //var note: Note?
            
            //Records if recipe was clicked
            //            CoreDataHelper.saveRecipe()
            //Check for duplicates in array before appending
            //            recipesClicked.append(recipe)
        }
    }

}
