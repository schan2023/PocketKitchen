//
//  File.swift
//  PocketKitchen
//
//  Created by Miguel Batilando on 7/16/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController {
    

    var ingredientArray = [String]()
    
    // IB Outlets
    @IBOutlet weak var ingredientInputTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var IngredientsTableView: ListIngredientsTableView!
    
    // IB Actions
    @IBAction func searchButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "recipeToList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destination = segue.destination as! RecipeListViewController
        //vc.finalIngredientList = self.ingredientArray
//        let vc = RecipeListViewController(nibName: "RecipeListViewController", bundle: nil)
        print("ingredientArray: \(ingredientArray)")
        destination.finalIngredientList = ingredientArray
        print("vc.finalIngredientList: \(destination.finalIngredientList)")
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let ingredient = ingredientInputTextField.text
        ingredientArray.append(ingredient!)
        print(ingredientArray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RecipeSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = String(ingredientArray[indexPath.row])
        return cell
    }
    
}
