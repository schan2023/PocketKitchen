//
//  HistoryViewController.swift
//  PocketKitchen
//
//  Created by Simone Chan on 7/16/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UITableViewController {
    
    var recipesClicked = [Recipe]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    func testFunc() {
        let recipe1 = CoreDataHelper.newRecipe()
        recipe1.name = "Spinach Cheddar Soup"
        recipe1.ingredients = "1.) Spinach 2.) Cheddar 3.) Broth"
        
        let recipe2 = CoreDataHelper.newRecipe()
        recipe2.name = "Banh Mi"
        recipe2.ingredients = "1.) Bread 2.) carrots"
        
        
        recipesClicked.append(recipe1)
        recipesClicked.append(recipe2)
        
        print(recipesClicked)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testFunc()
//        recipesClicked = CoreDataHelper.retrieveRecipes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return recipesClicked.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        
        let recipe = recipesClicked[indexPath.row]
        cell.recipeTitleLabel.text = recipe.name
        
//        cell.recipeTitleLabel.text = "Recipe 1"
//        cell.recipeDescriptionLabel.text = "This is the first recipe"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "displayRecipe" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recipe = recipesClicked[indexPath.row]
            let destination = segue.destination as! DisplayRecipeViewController
            destination.recipe = recipe //var note: Note?
            
            //Records if recipe was clicked
//            CoreDataHelper.saveRecipe()
            //Check for duplicates in array before appending
//            recipesClicked.append(recipe)
        }
    }
    
}
