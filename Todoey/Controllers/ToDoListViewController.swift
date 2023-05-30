//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    //    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        print(dataFilePath)
        
        let newItem = Item()
        newItem.title = "Eat Food"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Find keys"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Clean books"
        itemArray.append(newItem2)
        //        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
        //            itemArray = items
        //        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        //        if item.done == true {
        //            cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        }
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(itemArray[indexPath.row])
        
        //        itemArray[indexPath.row].done
        
        
        // sets done property to opposite of true or false statement
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //
        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        //        {
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //
        //        } else {
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //
        //        }
        
//        self.tableView.reloadData()
        saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    //MARK: - add new items section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once user clicks Add Item btn on UI alert
            //            print(textField.text)
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            //            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            //            let encoder = PropertyListEncoder()
            //
            //            do {
            //                let data = try encoder.encode(self.itemArray)
            //                try data.write(to: self.dataFilePath!)
            //
            //            } catch {
            //                print("Error encoding item array, \(error)")
            //            }
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK: - Model Manupulation Method
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()

    }
    
    
    
}

