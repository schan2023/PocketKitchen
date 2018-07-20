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
    
    var recipe: Recipe? = nil {
        didSet {
            recipeTitleLabel.text = recipe?.name
            recipeDescriptionLabel.text = recipe?.ingredients
        }
    }
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDescriptionLabel: UILabel!

    func switchFavorite(){
        if recipe?.isFavorited == "yes"{
            recipe?.isFavorited = nil
            print("swtiched to nil and then")
        }else{
            recipe?.isFavorited = "yes"
            print("switched to yes")
        }
    }
    @IBAction func likeButtonTapped(_ sender: Any) {
        print("like button tapped in favorited list")
        switchFavorite()
        //in here, save to coredata
    }
    
    @IBAction func likeButtonTappedHistory(_ sender: Any) {
        print("like button tapped in history")
        switchFavorite()
    }
    
}
