//
//  OrderDetailViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 22/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class OrderDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    //MARK:- Outlets
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var customerAddress: UILabel!
    @IBOutlet weak var customerLocation: UILabel!
    @IBOutlet weak var foodTableView: UITableView!
    
    var orderFoodArray = [FoodInfo](){
        didSet{
            self.foodTableView.reloadData()
        }
    }
    var customer:Customers!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let restaurentId = UserDefaults.standard.value(forKey: restaurentIDKey) as? String,let customerID = customer.CustomerID{
            loadOrdersFromDB(customerId: customerID, restaurentId: restaurentId)
        }
        
        setupViews()
    }
    
    //MARK:- TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderFoodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let food = orderFoodArray[indexPath.row]
        cell.textLabel?.text = food.Food_Name
        cell.detailTextLabel?.text = food.Food_Price
        return cell
    }
    
    //MARK:- My Functions
    
    func loadOrdersFromDB(customerId:String,restaurentId:String){
        
        let databaseRef = FIRDatabase.database().reference()
        let childRef = databaseRef.child("Orders").child(restaurentId).child(customerId)
        
        childRef.observe(.childAdded, with: { (snapshot) in
            if let foodDictionary = snapshot.value as? [String:String]{
                let food = FoodInfo()
                food.setValuesForKeys(foodDictionary)
                self.orderFoodArray.append(food)
//                print(snapshot) // Debugging Code
            }
        }, withCancel: nil)
    }
    
    func setupViews(){
        if let cust = customer{
            name.text = cust.CustomerName
            contactNumber.text = cust.CustomerPhoneNumber
            customerAddress.text = cust.CustomerAddress
            customerLocation.text = cust.CustomerLocation
        }
    }

}
