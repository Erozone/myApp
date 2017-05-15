//
//  FinalSignUpViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 15/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

class FinalSignUpViewController: UIViewController,UITextFieldDelegate{

    //MARK:- Outlet
    
    @IBOutlet weak var ownerEmail: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextField()
        // Do any additional setup after loading the view.
    }
    
    func customizeTextField(){
        ownerEmail = makeModTF(textFieldName: ownerEmail, placeHolderName: "Enter personal Email")
        passwordTF = makeModTF(textFieldName: passwordTF, placeHolderName: "Password")
        rePassword = makeModTF(textFieldName: rePassword, placeHolderName: "Re-Password")
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
    
}
