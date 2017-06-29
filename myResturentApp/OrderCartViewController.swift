//
//  OrderCartViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 01/06/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseDatabase


class OrderCartViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var RestaurentImageView: UIImageView!
    
    
    private let databaseRef = FIRDatabase.database().reference() //Firebase DB Refference
    
    var restaurentLocal: RestaurentData!
    var isFoodOrdered = false
    var customerId : String!
    
    var foodList = [FoodData](){
        didSet{
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                                                                     
        
        
        //        loadDataFromUserDefault()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let user_ID = UserDefaults.standard.string(forKey: "uid"){
            self.customerId = user_ID
            isFoodOrdered = true
            print(customerId)
        }
        
        if restaurent != nil{
            restaurentLocal = restaurent
        }
        
        loadDataFromUserDefault()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(FOOD_ORDER_NOTIFICATION)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath) as! OrderCartCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        
        let food = foodList[indexPath.row]
        
        cell.foodName.text = food.Food_Name
        cell.foodPrice.text = food.Food_Price
        cell.foodQuantity.text = "1"
        return cell
    }
    
    //MARK:- My Functions
    
    func displayAlert(title: String,displayMessage: String){
        let alert = UIAlertController(title: title, message: displayMessage, preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default){(_) in
            
        }
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadDataFromUserDefault(){
        if isFoodOrdered == true{
            if let custId = customerId{
                
                print(custId)
                
                if let decodedData = UserDefaults.standard.object(forKey: custId) as? Data{
                    if let decodedFoods =  NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [FoodData]{
                        
                        self.foodList = decodedFoods
                    }
                }
            }
        }else{ // If no food is ordered
            foodList = [FoodData]()
        }
    }
    
    func saveOdersToDatabase(category:String,foodName:String,foodPrice:String,restaurentId:String){
        
        let childRef = databaseRef.child("Orders").child(restaurentId).child(customerId).childByAutoId() //Child Refference
        
        let ordersValues: [String:Any] = ["Category":category,"Food_Name":foodName,"Food_Price":foodPrice,"Cusotmer_Id":customerId]
        
        childRef.updateChildValues(ordersValues) { (error, databaseRef) in
            if error != nil{
                print(error as Any)
                return
            }
            
//            print("Saved Orders data into database")
        }
    }
    
    //MARK:- Actions
    
    @IBAction func placeOrder(_ sender: UIButton) {
        
        if foodList.count != 0{
            for food in foodList{
                if let category = food.Category,let foodName = food.Food_Name,let foodPrice = food.Food_Price,let restaurentId = food.User_Id{
                    saveOdersToDatabase(category: category, foodName: foodName, foodPrice: foodPrice, restaurentId: restaurentId)
                }
            }
            
            UserDefaults.standard.removeObject(forKey: self.customerId)
            UserDefaults.standard.synchronize()
            
            displayAlert(title: "Order Placed", displayMessage: "Your Order Has Been Placed Sucessfully")
            
            print("Data Saved To Database and Removed From User Defaults")
            
            foodList = [FoodData]()
        }
        
        
    }
    
    
    
}
