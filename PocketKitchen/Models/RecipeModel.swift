//
//  RecipeModel.swift
//  PocketKitchen
//
//  Created by Simone Chan on 7/18/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation

struct RecipeModel {
    var name: String
    var ingredients: String
    var foodImage: String
    var directions: String
    var calories: Int32
    
    init(name: String, ingredients: String, foodImage: String, directions: String, calories: Int32) {
        self.name = name
        self.ingredients = ingredients
        self.foodImage = foodImage
        self.directions = directions
        self.calories = calories
    }
}
