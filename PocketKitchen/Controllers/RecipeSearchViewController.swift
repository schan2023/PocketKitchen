//
//  File.swift
//  PocketKitchen
//
//  Created by Miguel Batilando on 7/16/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController {
    
    var ingredientArray: [String] = [] {
        didSet {
            IngredientsTableView.reloadData()
        }
    }

    
    // IB Outlets
    @IBOutlet weak var ingredientInputTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var IngredientsTableView: ListIngredientsTableView!
    
    // IB Actions
    @IBAction func searchButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "recipeToList", sender: self)
        viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destination = segue.destination as! RecipeListViewController
        print("ingredientArray: \(ingredientArray)")
        destination.finalIngredientList = ingredientArray
        print("vc.finalIngredientList: \(destination.finalIngredientList)")

    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let ingredient = ingredientInputTextField.text
        ingredientArray.append(ingredient!)
        print(ingredientArray)
        let ingredientTableView = ListIngredientsTableView()
        ingredientTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension RecipeSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientTableViewCell
        let ingredient = ingredientArray[indexPath.row]
        print(ingredient)
        cell.ingredientLabel.text = ingredient
        return cell
    }
    
}
