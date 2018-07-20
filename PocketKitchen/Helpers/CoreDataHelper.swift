//
//  CoreDataHelper.swift
//  PocketKitchen
//
//  Created by Simone Chan on 7/17/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper {
    
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newRecipe() -> Recipe {
        let recipe = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context) as! Recipe
        
        return recipe
    }
    

    static func deleteRecipe(recipe:Recipe){
        context.delete(recipe)
        saveRecipe()
    }

    static func saveRecipe() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }

    
    static func retrieveRecipes(type: String) -> [Recipe] {
        do {
            //Retrieves core data and sorts it by isFavorited
            print("coredata helper retrieve recipes method")
            let fetchRequest = NSFetchRequest<Recipe>(entityName: "Recipe")
            let inputType: String = type
            if inputType == "favorites" {
                print("in the retrieveRecipes of tableview of favorites")
                fetchRequest.predicate = NSPredicate(format: "isFavorited = %@", "yes")
            }
            else if inputType == "history" {
                print("in the retrieveRecipes of tableview of history")
                fetchRequest.predicate = NSPredicate(format: "isClicked = %@", "yes")
            }
            let results = try context.fetch(fetchRequest)
            print("retrieveRecipes - printing results")
            return results
        }
        catch let error {
            print("Could not fetch results")
            return []
        }
    }
}
