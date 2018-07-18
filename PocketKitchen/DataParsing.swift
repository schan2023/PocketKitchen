//
//  DataParsing.swift
//  PocketKitchen
//
//  Created by Miguel Batilando on 7/17/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Recipe {
    
    let recipeTitle: String
    let ingredients: String
    let directionsURL: String
    let imageURL: String
    
    init(json: JSON) {
        self.recipeTitle = json["hits"][0]["recipe"]["label"].stringValue
        self.ingredients = json["hits"][0]["recipe"]["ingredientLines"].stringValue
        self.directionsURL = json["hits"][0]["recipe"]["url"].stringValue
        self.imageURL = json["hits"][0]["recipe"]["image"].stringValue
    }
    
}

