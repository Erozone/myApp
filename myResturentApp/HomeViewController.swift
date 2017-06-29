//
//  HomeViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 22/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth


private let reuseIdentifier = "mainCell"

class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var restaurents = [RestaurentData](){
        didSet{
            print("Executing")
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    var customerId:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRestaurents()

        if let user_ID = UserDefaults.standard.string(forKey: "uid"){
            self.customerId = user_ID
            print(customerId)
        }
    }
    
    //MARK:- My Functions
    
    func loadRestaurents(){
        let databaseRef = FIRDatabase.database().reference().child("Restaurents")
        
        databaseRef.observe(.value, with: { (snapshot) in
            
            if let userIdArray = snapshot.value{
                for val in (userIdArray as AnyObject).allValues{
                    if let dictionary = val as? [String:Any]{
                        let restaurent = RestaurentData()
                        restaurent.setValuesForKeys(dictionary)
                        
                        self.restaurents.append(restaurent)
                    }
                }
            }
           
            
        }, withCancel: nil)
        
        
    }
    
    //Navigation Controller
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCategoryMenu",let destination = segue.destination as? MenuCategoriesTableViewController{
            if let cell = sender as? MainCollectionViewCell{
                if let indexPath = self.collectionView?.indexPath(for: cell){
                    let selectedRow = restaurents[indexPath.row]
                    restaurent = selectedRow
                    destination.restaurentData = selectedRow
                    destination.userId = selectedRow.UID
                    destination.restaurent_ImageURLLocal = selectedRow.Profile_Image
                    destination.isCustomerLoggedIn = true
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurents.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCollectionViewCell
        let restaurentObj = restaurents[indexPath.row]
        
        cell.nameLabel.text = restaurentObj.Restaurent_Name
        cell.addressLabel.text = restaurentObj.Restaurent_Address
        cell.phoneNumber.text = "Phone: \(restaurentObj.Restaurent_Phone!)"
        if let imageUrlString = restaurentObj.Profile_Image{
            cell.restaurentImageView.loadImagesUsingCacheFromURLString(url: imageUrlString)
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height*0.20)
    }
    
    //MARK:- Action
    
    @IBAction func logoutBtn(_sender:UIButton){
        
        do{
            try FIRAuth.auth()?.signOut()
            print("Logout the User")
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectionVC")
            self.present(vc, animated: true, completion: nil)
            
        }catch let err as NSError{
            print(err.localizedDescription)
        }
        
//        if let bundle = Bundle.main.bundleIdentifier { //Clear the UserDefault
//            UserDefaults.standard.removePersistentDomain(forName: bundle)
//        }

    }
}

