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
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    @IBOutlet weak var createAccountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
    }
    
    //MARK:- User Functions
    
    func customizeView(){
        emailTF = emailTF.makeModTF(textFieldName: emailTF, placeHolderName: "Email")
        passwordTF = passwordTF.makeModTF(textFieldName: passwordTF, placeHolderName: "Password")
        
        let resetTap = UITapGestureRecognizer(target: self, action: #selector(resetPasswordBtnTapped))
        forgetPasswordLabel.addGestureRecognizer(resetTap)
        
        let signupTap = UITapGestureRecognizer(target: self, action: #selector(signUpBtnTapped))
        createAccountLabel.addGestureRecognizer(signupTap)
        
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        if let email = emailTF.text,let password = passwordTF.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error != nil{
                    print(error)
                    return
                }
                
                let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavHomeVC")
                
                self.present(vc, animated: true, completion: nil)
            })
        }
    }
    
    func resetPasswordBtnTapped(){
        print("Reset Button Tapped")
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResetView") as! ResetPasswordViewController
        vc.isCustomer = true
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func signUpBtnTapped(){
        print("SignUp Button Tapped")
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomerSignUp")
        self.present(vc, animated: true, completion: nil)
    }
    
}
