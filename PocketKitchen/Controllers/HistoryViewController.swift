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
    
}

func testFunc() {
    var foodArray = ["chicken", "cheese"]
    var foodVar = "chicken"
    let apiToContact = "https://api.edamam.com/search?q=\(foodVar)&app_id=58964742&app_key=af5da5d1d5d239130b3a195bd566f6cd"
    print(apiToContact)
}
