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
    
    init(json: JSON) {
        self.recipeTitle = json["hits"]["recipe"]["label"].stringValue
        self.ingredients = json["hits"]["recipe"]["ingredients"].stringValue
        self.directionsURL = json["hits"]["recipe"]["url"].stringValue
    }
    
}

