//
//  MenuCategoriesTableViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 16/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MenuCategoriesTableViewController: UITableViewController {
    
    //MARK:- Properties
    var categories = [Menu]()
    var foodDictionary = [String:Menu]()
    
    var handle: FIRAuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeMenu()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addCategories))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        handle = FIRAuth.auth()?.addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
            
            print("THIS IS LOGIN USER DETAILS FROM MENU CATEGORIES VC")
            
            if let user = user{
                print(user.email as Any)
                print("USER ID is \(user.uid)")

            }
            
            print("END OF THE USER DETAILS")
            
            // [END_EXCLUDE]
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        FIRAuth.auth()?.removeStateDidChangeListener(handle!)
    }
    
    //MARK:- My_Methodd
    
    private func getCurrentUserId()->String{
        let uid = FIRAuth.auth()?.currentUser?.uid
        return uid!
    }
    
    func observeMenu(){
        let uid = getCurrentUserId()
        let ref = FIRDatabase.database().reference().child("user-categories").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in

            let foodCategoryRef = FIRDatabase.database().reference().child("FoodCategory").child(snapshot.key)
            
            foodCategoryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String:Any]{
                    let menu = Menu()
                    menu.setValuesForKeys(dictionary)
                    
                    self.categories.append(menu)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            }, withCancel: nil)
            
        }, withCancel: nil)
        
    }
    
    func displayAlert(title: String,displayMessage: String){
        let alert = UIAlertController(title: title, message: displayMessage, preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default){(_) in
            if let field = alert.textFields![0] as? UITextField{
                if let category = field.text{
                    print(category)
                    
                    let databaseRef = FIRDatabase.database().reference()
                    let childRef = databaseRef.child("FoodCategory").childByAutoId()
                    
                    let uid = self.getCurrentUserId()
                    
                    let values = ["Category":category,"User_Id":uid]
                    
                    childRef.updateChildValues(values, withCompletionBlock: { (error, databaseRef) in
                        
                        if error != nil{
                            print(error!)
                        }
                        
                        let userCategoryRef = FIRDatabase.database().reference().child("user-categories").child(uid)
                        
                        let userCategory = childRef.key
                        userCategoryRef.updateChildValues([userCategory:1])
                        
                        //Category sucessfully saved
                    })
                }
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
        
        cell.textLabel!.text = categories[indexPath.row].Category
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
        if segue.identifier == "toMenuVC",let destination = segue.destination as? MenuCollectionView,let indexPath = self.tableView.indexPathForSelectedRow{
            destination.categoryName = categories[indexPath.row].Category
        }
    }

    //MARK:- Action Methods
    
    func addCategories(){
        displayAlert(title: "Add Food Category", displayMessage: "Enter Food Category")
    }
    
}
