//
//  FoodData.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 17/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import Foundation
import UIKit

class FoodData : NSObject,NSCoding{
    
    var Category:String?
    var Food_Name:String?
    var Food_Price:String?
    var Food_Image_URL:String?
    var User_Id:String?
    
    init(Category: String?, Food_Name: String,Food_Price: String ,Food_Image_URL: String,User_Id: String) {
        self.Category = Category
        self.Food_Name = Food_Name
        self.Food_Price = Food_Price
        self.Food_Image_URL = Food_Image_URL
        self.User_Id = User_Id
        
    }
    
    override init() {
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let Category = aDecoder.decodeObject(forKey: "Category") as! String
        let Food_Name = aDecoder.decodeObject(forKey: "Food_Name") as! String
        let Food_Price = aDecoder.decodeObject(forKey: "Food_Price") as! String
        let Food_Image_URL = aDecoder.decodeObject(forKey: "Food_Image_URL") as! String
        let User_Id = aDecoder.decodeObject(forKey: "User_Id") as! String
        self.init(Category: Category, Food_Name: Food_Name, Food_Price: Food_Price, Food_Image_URL: Food_Image_URL, User_Id: User_Id)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Category, forKey: "Category")
        aCoder.encode(Food_Name, forKey: "Food_Name")
        aCoder.encode(Food_Price, forKey: "Food_Price")
        aCoder.encode(Food_Image_URL, forKey: "Food_Image_URL")
        aCoder.encode(User_Id, forKey: "User_Id")
    }
    
}
