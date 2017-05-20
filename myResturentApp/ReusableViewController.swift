//
//  ReusableViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 20/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

public class ReusableViewController: UIViewController,UITextFieldDelegate {

    override public func viewDidLoad() {
         super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func makeModTF(textFieldName:UITextField,placeHolderName: String)->UITextField{
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        
        textFieldName.layer.cornerRadius = 20
        textFieldName.layer.borderColor = UIColor.white.cgColor
        textFieldName.layer.borderWidth = 1
        textFieldName.leftView = paddingView
        textFieldName.leftViewMode = .always
        textFieldName.attributedPlaceholder = NSAttributedString(string: placeHolderName, attributes: [NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName : UIFont(name: "Roboto", size: 18)!])
        textFieldName.layer.masksToBounds = false
        textFieldName.delegate = (self as! UITextFieldDelegate)
        return textFieldName
    }
    

}
