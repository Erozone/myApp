//
//  SignUpViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 15/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate{
    
    //MARK:- Outlets
    
    @IBOutlet weak var restName: UITextField!
    @IBOutlet weak var resAddress: UITextField!
    @IBOutlet weak var resLocation: UITextField!
    @IBOutlet weak var resPincode: UITextField!
    @IBOutlet weak var resLandMark: UITextField!
    @IBOutlet weak var resPhone: UITextField!
    @IBOutlet weak var resEmail: UITextField!
    
    func customizeTextField(){
        restName = makeModTF(textFieldName: restName, placeHolderName: "Restaurent Name")
        resAddress = makeModTF(textFieldName: resAddress, placeHolderName: "Street Address")
        resLocation = makeModTF(textFieldName: resLocation, placeHolderName: "Location")
        resPincode = makeModTF(textFieldName: resPincode, placeHolderName: "Pincode")
        resLandMark = makeModTF(textFieldName: resLandMark, placeHolderName: "Landmark")
        resPhone = makeModTF(textFieldName: resPhone, placeHolderName: "Phone")
        resEmail = makeModTF(textFieldName: resEmail, placeHolderName: "Restaurent Email")
    }
    
    func makeModTF(textFieldName:UITextField,placeHolderName: String)->UITextField{
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        
        textFieldName.layer.cornerRadius = 20
        textFieldName.layer.borderColor = UIColor.white.cgColor
        textFieldName.layer.borderWidth = 1
        textFieldName.leftView = paddingView
        textFieldName.leftViewMode = .always
        textFieldName.attributedPlaceholder = NSAttributedString(string: placeHolderName, attributes: [NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName : UIFont(name: "Roboto", size: 18)!])
        textFieldName.layer.masksToBounds = false
        textFieldName.delegate = self
        return textFieldName
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextField()
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Actions
    
    @IBAction func nextScene(_ sender: DesignableButton) {
        self.performSegue(withIdentifier: "toNextScene", sender: self)
    }
}
