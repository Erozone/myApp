//
//  MenuViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 16/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

class FoodData{
    var foodImage:UIImage!
    var foodName:String!
    var foodPrice:String!
    
    init(image:UIImage,name:String,price:String) {
        foodName = name
        foodImage = image
        foodPrice = price
    }
}

class MenuViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var collectionView:UICollectionView!
    
    var images = [UIImage(named:"food1"),UIImage(named:"food1")]
    var dishName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = dishName
        
        setupCollectionView();
    }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 25
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
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCollectionViewCell
        cell.awakeFromNib()
        cell.foodImageView.image = images[indexPath.row]
        cell.foodName.text = "Default Name"
        cell.foodPrice.text = "Default Price"
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
    
    

}
