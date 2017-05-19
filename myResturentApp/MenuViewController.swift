//
//  MenuViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 16/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MenuViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var collectionView:UICollectionView!
    var images = [UIImage(named:"food1"),UIImage(named:"food1")]
    var dishName:String!
    var foodList = [FoodData]()
    var food:FoodData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = dishName
        setupCollectionView();
    }
    
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
        cell.foodImageView.image = food.foodImage
        cell.foodName.text = food.foodName
        cell.foodPrice.text = food.foodPrice
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height*0.12)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddFood",let destination = segue.destination as? AddFoodViewController{
            destination.categoryOfDish = dishName
        }
    }
    
    @IBAction func cancelToMenuViewController(segue:UIStoryboardSegue){
        
    }
    
    @IBAction func saveFood(segue:UIStoryboardSegue){
        if let addFoodVC = segue.source as? AddFoodViewController {
            if let food = addFoodVC.food{
                
                saveFoodToDatabase()
                
                foodList.append(food)
                let indexPath = IndexPath(row: foodList.count-1, section: 0)
                collectionView.insertItems(at: [indexPath])
            }
        }
    }
    
    func saveFoodToDatabase(){
        let databaseRef = FIRDatabase.database().reference()
        let childRef = databaseRef.child("Foods").childByAutoId()
    }

}
