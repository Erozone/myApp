//
//  FoodData.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 17/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import Foundation
import UIKit

class FoodData{
    var foodImage:UIImage!
    var foodName:String!
    var foodPrice:String!
    var dishCategory:String!
    
    init(image:UIImage,name:String,price:String,category:String) {
        foodName = name
        foodImage = image
        foodPrice = price
        dishCategory = category
    }
}
