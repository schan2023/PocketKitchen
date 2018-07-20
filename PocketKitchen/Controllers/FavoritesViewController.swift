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
    
    var favoritedRecipes = [Recipe](){
        didSet {
            tableView.reloadData()
        }
    }
    
    func callingCoreData(){
        let favoriteType = "yes"
        favoritedRecipes = CoreDataHelper.retrieveRecipes(type: favoriteType)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        callingCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        callingCoreData()
        tableView.reloadData()
        print("tableView should be reloaded")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return favoritedRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        let recipe = favoritedRecipes[indexPath.row]
        cell.recipe = recipe
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
    }

}
