//
//  RecipeModel.swift
//  PocketKitchen
//
//  Created by Simone Chan on 7/18/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit

struct RecipeModel {
    var name: String
    var ingredients: String
    var foodImage: String
    var directions: String
    var calories: Int
    var recipeUIImage: UIImage?
    
    init(name: String, ingredients: String, foodImage: String, directions: String, calories: Int) {
        self.name = name
        self.ingredients = ingredients
        self.foodImage = foodImage
        self.directions = directions
        self.calories = calories
    }
}
