//
//  DesignableButton.swift
//  LoginDemo
//
//  Created by Mohit Kumar on 09/01/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

@IBDesignable class DesignableButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0.0{ // This allow to have border to the button
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0{ // This allow to have rounded Corners to the button
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{ // This allow to have border to a color
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
