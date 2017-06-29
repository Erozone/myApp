//
//  FoodRestaurent.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 27/06/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

class CustomerDetails{
    
    let customer:Customers?
    let food:FoodInfo?
    
    init(customer:Customers,food:FoodInfo) {
        self.customer = customer
        self.food = food
    }
    
}
