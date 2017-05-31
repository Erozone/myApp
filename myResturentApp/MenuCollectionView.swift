//
//  MenuCollectionView.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 22/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

private let reuseIdentifier = "foodCell"

class MenuCollectionView: UICollectionViewController ,UICollectionViewDelegateFlowLayout{
    
    var categoryName:String!
    var foodList = [FoodData](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    var userId:String? = nil
    
    var handle: FIRAuthStateDidChangeListenerHandle?
    var customerLoggedIn = false
    
    //View Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = categoryName
        loadDataFromDatabase()
    }
    
       
    //MARK:- My Fuctions
    
    private func ifUserLoggedIn()->Bool{
        if let uid = FIRAuth.auth()?.currentUser?.uid{
            userId = uid
            return true
        }else{
            return false
        }
    }
    
    func loadDataFromDatabase(){
        
        if userId != nil{
//            self.navigationItem.rightBarButtonItem = nil
        }else{
            if let uid = FIRAuth.auth()?.currentUser?.uid{
                userId = uid
            }
        }
        
        let ref = FIRDatabase.database().reference().child("Food_Owner").child(userId!)
        ref.observe(.childAdded, with: { (snapshot) in
            
            let foodCategoryRef = FIRDatabase.database().reference().child("Foods").child(snapshot.key)
            
            foodCategoryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String:Any]{
                    let food = FoodData()
                    food.setValuesForKeys(dictionary)
                    
                    if self.categoryName == food.Category{
                        self.foodList.append(food)
                    }
                }
                
            }, withCancel: nil)
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        }, withCancel: nil)
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoodCollectionViewCell
        
        let food = foodList[indexPath.row]
        
        print("Total Values in array is: \(foodList.count)")
        
        cell.foodName.text = food.Food_Name
        cell.foodPrice.text = "Price \(food.Food_Price!)"
        
        if let imageUrlString = food.Food_Image_URL{
            cell.foodImageView.loadImagesUsingCacheFromURLString(url: imageUrlString)
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height*0.25)
    }
    
    
    
    //MARK: - Navigation Controls
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddFood",let destination = segue.destination as? AddFoodViewController{
            destination.categoryOfDish = categoryName
        }
    }
    
    //MARK:- My Functions
    
    @IBAction func cancelToMenuViewController(segue:UIStoryboardSegue){
        
    }
    
    @IBAction func saveFood(segue:UIStoryboardSegue){
        if let addFoodVC = segue.source as? AddFoodViewController {
            
            if let foodCategory = addFoodVC.categoryOfDish,let foodName = addFoodVC.dishNameTF.text,let foodPrice = addFoodVC.dishPriceTF.text,let dishImage = addFoodVC.dishImageView.image{
                saveFoodToDatabase(category: foodCategory, foodName: foodName, foodPrice: foodPrice, foodImage: dishImage,userId:userId!)
            }
        }
    }
    
    func saveFoodToDatabase(category:String,foodName:String,foodPrice:String,foodImage:UIImage,userId:String){
        
        let databaseRef = FIRDatabase.database().reference()
        let childRef = databaseRef.child("Foods").childByAutoId()
        
        //Save Restaurent Image
        var data = NSData()
        
        data = UIImageJPEGRepresentation(foodImage,0.5)! as NSData
        let storageRef = FIRStorage.storage().reference().child("\(foodName).png")
        
        storageRef.put(data as Data, metadata: nil) { (metadata, error) in
            
            if error != nil{
                print(error as Any)
                return
            }
            
            if let foodImageUrl = metadata?.downloadURL()?.absoluteString{
                let values: [String:Any] = ["Category":category,"Food_Name":foodName,"Food_Price":foodPrice,"Food_Image_URL":foodImageUrl,"User_Id":userId]
                
                childRef.updateChildValues(values, withCompletionBlock: { (err, databaseRef) in
                    if err != nil{
                        print(err as Any)
                        return
                    }
                    
                    let foodCategoryRef = FIRDatabase.database().reference().child("Food_Owner").child(userId)
                    
                    let foodCate = childRef.key
                    foodCategoryRef.updateChildValues([foodCate:"Food_Key"])
                    print("Saved the data into database")
                    
                })
            }
        }
        
        
    }

}
