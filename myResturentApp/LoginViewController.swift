//
//  ViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 15/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController,UITextFieldDelegate {
    
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
    
    func displayAlert(title: String,displayError: String){
        let alert = UIAlertController(title: title, message: displayError, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
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
    
    @IBAction func loginBtnPress(_ sender:UIButton){
        if let email = emailTFOutlet.text,let password = passwordTFOutlet.text{
            FIRAuth.auth()?.signIn(withEmail:email , password: password, completion: { (user:FIRUser?, error) in
                if error != nil{
                    self.displayAlert(title: "Error", displayError: (error?.localizedDescription)!)
                }
                
                print("You have sucessfully Login In")
                
                self.performSegue(withIdentifier: "toRestaurentDashboard", sender: self)
                
            })
        }
    }
    
}

