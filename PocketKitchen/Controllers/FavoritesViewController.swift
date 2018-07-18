//
//  FavoritesViewController.swift
//  PocketKitchen
//
//  Created by Elaina Teramoto on 7/18/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit

class FavoritesViewController: UITableViewController {
    
    
    var favoritedRecipes = [Recipe]() {
        didSet {
            tableView.reloadData()
        }
    }

    @IBAction func likeButtonTappedFavoritesBoard(_ sender: Any) {
        print("yay im on the favorites board")
        hitLike()
    }
    func hitLike(){
        print("in favorites view controller.. going to core data helper to save recipe")
        //print(favoritedRecipes)
        
        
        let recipe1 = CoreDataHelper.newRecipe()
        recipe1.name = "Elaina"
        recipe1.ingredients = "1.) Tomato"
        favoritedRecipes.append(recipe1)
        

    }
    
    func testFunc() {
        let recipe1 = CoreDataHelper.newRecipe()
        recipe1.name = "Spinach Cheddar Soup"
        recipe1.ingredients = "1.) Spinach 2.) Cheddar 3.) Broth"

        let recipe2 = CoreDataHelper.newRecipe()
        recipe2.name = "Banh Mi"
        recipe2.ingredients = "1.) Bread 2.) carrots"

        let recipe3 = CoreDataHelper.newRecipe()
        recipe3.name = "Elaina's amazing sandwich"
        recipe3.ingredients = "1.) Bread 2.) Arugula 3). Turkey"


        favoritedRecipes.append(recipe1)
        favoritedRecipes.append(recipe2)
        favoritedRecipes.append(recipe3)
        print(favoritedRecipes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testFunc()
        //favoritedRecipes = CoreDataHelper.retrieveRecipes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return favoritedRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        
        let recipe = favoritedRecipes[indexPath.row]
        cell.recipeTitleLabel.text = recipe.name
        
        //        cell.recipeTitleLabel.text = "Recipe 1"
        //        cell.recipeDescriptionLabel.text = "This is the first recipe"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "displayRecipe" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recipe = favoritedRecipes[indexPath.row]
            let destination = segue.destination as! DisplayRecipeViewController
            destination.recipe = recipe //var note: Note?
            
            //Records if recipe was clicked
            //            CoreDataHelper.saveRecipe()
            //Check for duplicates in array before appending
            //            recipesClicked.append(recipe)
        }
//        else if identifier == "likeButtonTappedHistoryBoard"{
//            print("likeButtonTappedHistoryBoard was tapppppped!!")
//        }
    }
    
    
    
    
}
