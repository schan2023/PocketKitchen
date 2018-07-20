//
//  HistoryViewController.swift
//  PocketKitchen
//
//  Created by Simone Chan on 7/16/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HistoryViewController: UITableViewController {
    
    var recipesClicked = [Recipe]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesClicked = CoreDataHelper.retrieveRecipes(type: "history")
        print(recipesClicked)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return recipesClicked.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        
        let recipe = recipesClicked[indexPath.row]
        let imageURL = recipe.imageUrl
        cell.recipeTitleLabel.text = recipe.name
        let calorieStr = String(recipe.calories) + " calories"
        cell.recipeDescriptionLabel.text = calorieStr
        Alamofire.request(imageURL!).responseImage { response in
            if let image = response.result.value {
                cell.foodImage.image = image
            }
        }
        
        return cell
//        let recipe = recipesClicked[indexPath.row]
//        cell.recipeTitleLabel.text = recipe.name
//
//        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "displayRecipe" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recipe = recipesClicked[indexPath.row]
            let destination = segue.destination as! DisplayRecipeViewController
            destination.recipe = recipe
        }
    }
    
}
