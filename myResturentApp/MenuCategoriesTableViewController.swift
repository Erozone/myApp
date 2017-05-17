//
//  MenuCategoriesTableViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 16/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

class MenuCategoriesTableViewController: UITableViewController {
    
    var categories = [String]()

//    "Starters","Roti/Breads","Main Chicken Dishes","Lamb Dishes","Sea Food Dishes","Vegetarian Dishes","Rice","Chinese Dishes"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addCategories))
        
        
    }
    
    //MARK:- My_Methods
    
    func displayAlert(title: String,displayMessage: String){
        let alert = UIAlertController(title: title, message: displayMessage, preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default){(_) in
            if let field = alert.textFields![0] as? UITextField{
                print(field.text!)
                self.categories.append(field.text!)
                
                let indexPath = IndexPath(row: self.categories.count-1,section:0)
                self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }else{
                //DidN't Enter
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (_) in
            
        }
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Category of Dish"
        })
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel!.text = categories[indexPath.row]
        cell.textLabel!.font = UIFont(name: "Roboto", size: 30)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMenuVC", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.size.height*0.08)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMenuVC",let destination = segue.destination as? MenuViewController,let indexPath = self.tableView.indexPathForSelectedRow{
            destination.dishName = categories[indexPath.row]
        }
    }

    //MARK:- Action Methods
    
    func addCategories(){
        displayAlert(title: "Add Food Category", displayMessage: "Enter Food Category")
    }
    
}
