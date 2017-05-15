//
//  ViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 15/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    //MARK:- Outlets

    @IBOutlet weak var emailTFOutlet: UITextField!
    @IBOutlet weak var passwordTFOutlet: UITextField!
    
    func designTextField(){
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        
        emailTFOutlet.layer.cornerRadius = 20
        emailTFOutlet.layer.borderColor = UIColor.white.cgColor
        emailTFOutlet.layer.borderWidth = 1
        emailTFOutlet.leftView = paddingView
        emailTFOutlet.leftViewMode = .always
        emailTFOutlet.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName : UIFont(name: "Roboto", size: 18)!])
        emailTFOutlet.layer.masksToBounds = false
        
        passwordTFOutlet.layer.cornerRadius = 20
        passwordTFOutlet.layer.borderColor = UIColor.white.cgColor
        passwordTFOutlet.layer.borderWidth = 1
        passwordTFOutlet.leftView = paddingView1
        passwordTFOutlet.leftViewMode = .always
        passwordTFOutlet.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName : UIFont(name: "Roboto", size: 18)!])
        passwordTFOutlet.layer.masksToBounds = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designTextField()
        emailTFOutlet.delegate = self
        passwordTFOutlet.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Actions
    
    
    @IBAction func createAccountBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSignUp", sender: self)
    }


}

