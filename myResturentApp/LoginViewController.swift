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
    
    var handle: FIRAuthStateDidChangeListenerHandle?
    
    func customizeTextField(){
        emailTFOutlet = emailTFOutlet.makeModTF(textFieldName: emailTFOutlet, placeHolderName: "Email")
        passwordTFOutlet = passwordTFOutlet.makeModTF(textFieldName: passwordTFOutlet, placeHolderName: "Password")
    }
    
    func displayAlert(title: String,displayError: String){
        let alert = UIAlertController(title: title, message: displayError, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeTextField()
        emailTFOutlet.delegate = self
        passwordTFOutlet.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Actions
    
    
    @IBAction func loginBtnPress(_ sender:UIButton){
        if let email = emailTFOutlet.text,let password = passwordTFOutlet.text{
            FIRAuth.auth()?.signIn(withEmail:email , password: password, completion: { (user:FIRUser?, error) in
                
                if error != nil{
                    self.displayAlert(title: "Error", displayError: (error?.localizedDescription)!)
                    return
                }
                
                print("You have sucessfully Login In")
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RestHomeVC")
                self.present(vc, animated: true, completion: nil)
                
            })
        }
    }

}

