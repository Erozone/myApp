//
//  CustomerLoginViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 24/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CustomerLoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK:- User Functions
    
    func customizeView(){
        emailTF = emailTF.makeModTF(textFieldName: emailTF, placeHolderName: "Email")
        passwordTF = passwordTF.makeModTF(textFieldName: passwordTF, placeHolderName: "Password")
        
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        if let email = emailTF.text,let password = passwordTF.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error != nil{
                    print(error as Any)
                    return
                }
                
                let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavHomeVC")
                
                self.present(vc, animated: true, completion: nil)
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResetCustomer",let destination = segue.destination as? ResetPasswordViewController{
            destination.isCustomer = true
        }
    }
    
    //MARK:- Actions
    
}
