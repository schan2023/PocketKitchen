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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        
        cell.recipeTitleLabel.text = "Recipe 1"
        cell.recipeDescriptionLabel.text = "This is the first recipe"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1
        guard let identifier = segue.identifier else { return }
        
        // 2
        if identifier == "displayRecipe" {
            print("Transitioning to the Display Recipe View Controller")
        }
    }
    
}
