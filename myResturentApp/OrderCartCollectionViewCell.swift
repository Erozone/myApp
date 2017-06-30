//
//  OrderCartCollectionViewCell.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 01/06/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

class OrderCartCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodQuantity: UILabel!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalRupees: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myStepper.minimumValue = 1
    }
    
    @IBAction func StepperTapped(_ sender: UIStepper) {
        
        if let originalPrice = foodPrice.text,let foodName = foodName.text{
            var originalPrice = originalPrice
            if let value = UserDefaults.standard.value(forKey: foodName) as? String{
                originalPrice = value
            }else{
                UserDefaults.standard.setValue(originalPrice, forKey: foodName)
                UserDefaults.standard.synchronize()
            }
            
            let quantity = Int(sender.value)
            let priceOfFood = quantity*Int(originalPrice)!
            foodPrice.text = priceOfFood.description
            foodQuantity.text = quantity.description
        }
    }
}
