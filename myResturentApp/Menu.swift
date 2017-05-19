//
//  Menu.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 18/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import Foundation
import UIKit

class Menu{
    
    var nameOfCategory:String?
    var foodList: FoodData?
    
    init(category:String,food: FoodData) {
        self.nameOfCategory = category
        self.foodList = food
    }
}
