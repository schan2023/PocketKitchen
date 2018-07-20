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
    
//    var recipe: RecipeModel?
    var recipe: Recipe?
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingredientTextLabel: UILabel!
    @IBOutlet weak var directionsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        directionsButton.layer.cornerRadius = 10
        directionsButton.layer.borderWidth = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let recipe = recipe {
            recipeNameLabel.text = recipe.name
            ingredientTextLabel.text = recipe.ingredients
            ingredientTextLabel.layer.borderWidth = 0.25
            ingredientTextLabel.layer.borderColor = UIColor.black.cgColor
            Alamofire.request(recipe.imageUrl!).responseImage { response in
                if let image = response.result.value {
                   self.recipeImage.image = image
                }
            }
            
        } else {
            recipeNameLabel.text = ""
        }
    }
    
    @IBAction func directionsButtonPressed(_ sender: Any) {
        let urlString = (recipe?.directions)!
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:])
        }
}

}
