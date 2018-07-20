//
//  DisplayRecipeViewController.swift
//  PocketKitchen
//
//  Created by Simone Chan on 7/17/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit

class DisplayRecipeViewController: UIViewController {
    
    //var recipe: RecipeModel?
    var recipe: Recipe?
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let recipe = recipe {
            recipeNameLabel.text = recipe.name
            ingredientsTextView?.text = recipe.ingredients
        } else {
            recipeNameLabel.text = ""
            ingredientsTextView.text = ""
        }
    }

}

