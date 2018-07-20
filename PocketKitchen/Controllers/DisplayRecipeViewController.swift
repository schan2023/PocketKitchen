//
//  DisplayRecipeViewController.swift
//  PocketKitchen
//
//  Created by Simone Chan on 7/17/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

class DisplayRecipeViewController: UIViewController {
    
    var recipe: RecipeModel?
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingredientTextLabel: UILabel!
    @IBOutlet weak var directionsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if var recipe = recipe {
            recipeNameLabel.text = recipe.name
            print("recipes.ingredients: \(recipe.ingredients)")
            // ingredientsTextView?.text = recipe.ingredients
            ingredientTextLabel.text = recipe.ingredients
            ingredientTextLabel.layer.borderWidth = 0.25
            ingredientTextLabel.layer.borderColor = UIColor.black.cgColor
            Alamofire.request(recipe.foodImage).responseImage { response in
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    // cell.foodImage.image = image
                    self.recipeImage?.image = image
                }
            }
        } else {
            recipeNameLabel.text = ""
            // ingredientsTextView.text = ""
        }
    }
    
    @IBAction func directionsButtonPressed(_ sender: Any) {
        let urlString = (recipe?.directions)!
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:])
        }
}

}
