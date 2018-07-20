//
//  RecipeTableViewCell.swift
//  PocketKitchen
//
//  Created by Simone Chan on 7/16/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    var recipeCoreData: Recipe?
    var recipe: RecipeModel? = nil {
        didSet {
            recipeTitleLabel.text = recipe?.name
            //recipeDescriptionLabel.text = recipe?.ingredients
        }
    }
    func switchFavorite(){
        if recipeCoreData?.isFavorited == "yes"{
            recipeCoreData?.isFavorited = nil
            print("swtiched to nil and then")
        }else{
            recipeCoreData?.isFavorited = "yes"
            print("switched to yes")
        }
    }
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDescriptionLabel: UILabel!

    @IBAction func likeButtonTapped(_ sender: Any) {
        print("like button tapped in favorited list")
        switchFavorite()
    }
    
    @IBAction func likeButtonTappedHistory(_ sender: Any) {
        print("like button tapped in history")
        switchFavorite()
    }
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var recipeCalorieLabel: UILabel!
    
}
