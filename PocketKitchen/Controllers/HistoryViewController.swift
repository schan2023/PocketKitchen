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
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return recipesClicked.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        
        cell.recipeTitleLabel.text = "Recipe 1"
        cell.recipeDescriptionLabel.text = "This is the first recipe"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "displayRecipe" {
            print("Transitioning to the Display Recipe View Controller")
        }
    }
    
}
