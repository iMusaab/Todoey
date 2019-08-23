//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Musaab mohammed on 20/08/2019.
//  Copyright © 2019 Musaab mohammed. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?


    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    //MARK: - Add New Caegory
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFieled = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            
            newCategory.name = textFieled.text!

            
            self.save(category: newCategory)
            
            self.tableView.reloadData()
            
            
        }
        alert.addAction(action)
        
        alert.addTextField { (fieled) in
            textFieled = fieled
            textFieled.placeholder = "Add a New Category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row]["name"] as? String ?? "No categories added yet"
        
        return cell
    }
    
    //MARK: - TableView Manipulation Methods
    func save(category: Category) {
        
        do {
            
            try realm.write {
                realm.add(category)
            }
            
        } catch {
            print("Error saving Context \(error)")
        }
        
        tableView.reloadData()
        
    }
        
        func loadCategories() {
            
            categoryArray = realm.objects(Category.self)
            
            tableView.reloadData()
        }
    
    //MARK: - TableView Delgate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinatioVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinatioVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }

        
    }
    

