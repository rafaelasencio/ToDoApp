//
//  CategoryViewController.swift
//  toDoListApp
//
//  Created by Rafael Asencio on 22/10/2018.
//  Copyright © 2018 Rafael Asencio. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
import Firebase

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()

    var categories : Results<Category>?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        tableView.separatorStyle = .none
        
    }
    
    

    //    MARK: - TableView Datasource Methods


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            
            cell.textLabel?.text = category.name
            
            guard let categoryColour = UIColor(hexString: category.colour) else { fatalError() }
            
            cell.backgroundColor = categoryColour
            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! toDoListViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
     func goToLogin() {
        guard let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController else {
                return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
        vc.view.frame = rootViewController.view.frame
        vc.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = vc
        }, completion: { _ in
            // maybe do something here
        })
    }
    
    //    MARK: Buttons 
    @IBAction func logOutBarButton(_ sender: UIBarButtonItem) {
        
        do {
            try FIRAuth.auth()?.signOut()
            
        }
        catch {
            print("Error signin out ")
        }
        
        navigationController?.popToRootViewController(animated: true)
        goToLogin()

    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            // What will happen once the user clicks the Add Item button on our UIAlert
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //    MARK: - TableView Delegate Methods
    
    
    //    MARK: - Data Manipulation Methods

    
    func loadCategories()  {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }

    func save(category: Category)  {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving contect \(error)") }
        
        self.tableView.reloadData()
    }

    //        MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")}
        }
    }
    
    
}


