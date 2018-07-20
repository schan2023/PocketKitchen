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
        cell.recipeTitleLabel.text = recipe.name
        
        return cell
    }
    
}
