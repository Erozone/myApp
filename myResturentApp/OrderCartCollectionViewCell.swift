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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myStepper.minimumValue = 1
    }
    
    
    @IBAction func StepperTapped(_ sender: UIStepper) {
        foodQuantity.text = Int(sender.value).description
    }
}
