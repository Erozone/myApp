//
//  MenuViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 16/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class MenuViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var collectionView:UICollectionView!
    var images = [UIImage(named:"food1"),UIImage(named:"food1")]
    var categoryName:String!
    var foodList = [FoodData]()
    var food:FoodData?
    
    var handle: FIRAuthStateDidChangeListenerHandle?
    
    func loadDataFromDatabase(){
        
        let ref = FIRDatabase.database().reference().child("Foods")
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String:Any]{
                
                let foodObj = FoodData()
                foodObj.setValuesForKeys(dictionary)
                
                if let uid = FIRAuth.auth()?.currentUser?.uid{
                    if self.categoryName == foodObj.Category,uid == foodObj.User_Id{
                        self.foodList.append(foodObj)
                    }
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }, withCancel: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = categoryName
        setupCollectionView();
        loadDataFromDatabase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        handle = FIRAuth.auth()?.addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
            
            print("THIS IS LOGIN USER DETAILS FROM RESTAURENT VC")
            
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

    //MARK:- CollectionView Methods
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: "foodCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCollectionViewCell
        cell.awakeFromNib()
        let food = foodList[indexPath.row]
        cell.foodName.text = food.Food_Name
        cell.foodPrice.text = food.Food_Price
        setImageToCell(imageUrlString: food.Food_Image_URL!, cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height*0.12)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddFood",let destination = segue.destination as? AddFoodViewController{
            destination.categoryOfDish = categoryName
        }
    }
    
    private func setImageToCell(imageUrlString:String,cell: FoodCollectionViewCell){
        if let url = URL(string: imageUrlString){
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil{
                    print(error as Any)
                    return
                }
                
                DispatchQueue.main.async {
                    cell.foodImageView.image = UIImage(data: data!)
                }
                
            }).resume()
        }
    }
    
    @IBAction func cancelToMenuViewController(segue:UIStoryboardSegue){
        
    }
    
    @IBAction func saveFood(segue:UIStoryboardSegue){
        if let addFoodVC = segue.source as? AddFoodViewController {
            
            if let foodCategory = addFoodVC.categoryOfDish,let foodName = addFoodVC.dishNameTF.text,let foodPrice = addFoodVC.dishPriceTF.text,let dishImage = addFoodVC.dishImageView.image,let uid = FIRAuth.auth()?.currentUser?.uid{
                saveFoodToDatabase(category: foodCategory, foodName: foodName, foodPrice: foodPrice, foodImage: dishImage,userId:uid)
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
                print(error)
                return
            }
            
            if let foodImageUrl = metadata?.downloadURL()?.absoluteString{
                let values: [String:Any] = ["Category":category,"Food_Name":foodName,"Food_Price":foodPrice,"Food_Image_URL":foodImageUrl,"User_Id":userId]
                
                childRef.updateChildValues(values, withCompletionBlock: { (err, databaseRef) in
                    if err != nil{
                        print(err)
                        return
                    }
                    
                    print("Saved the data into database")
                    
                })
            }
        }
        
        
    }

}
