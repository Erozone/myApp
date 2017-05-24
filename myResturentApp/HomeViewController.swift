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


private let reuseIdentifier = "mainCell"

class HomeViewController: UICollectionViewController {
    
    var restaurents = [RestaurentData](){
        didSet{
            print("Executing")
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRestaurents()

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
                    destination.userId = selectedRow.UID
                    destination.cameFromHomeVc = true
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
        if let imageUrlString = restaurentObj.Profile_Image{
            cell.restaurentImageView.loadImagesUsingCacheFromURLString(url: imageUrlString)
        }
    
        return cell
    }

}

