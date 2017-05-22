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
        emailTFOutlet = makeModTF(textFieldName: emailTFOutlet, placeHolderName: "Email")
        passwordTFOutlet = makeModTF(textFieldName: passwordTFOutlet, placeHolderName: "Password")
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        handle = FIRAuth.auth()?.addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
            
            print("THIS IS LOGIN USER DETAILS FROM LOGIN VC")
            
            if let user = user{
                print(user.email as Any)
            }
        
            print(auth.currentUser as Any)
            
            print("END OF THE USER DETAILS")
            
            // [END_EXCLUDE]
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        FIRAuth.auth()?.removeStateDidChangeListener(handle!)
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
                    return
                }
                
                print("You have sucessfully Login In")
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RestHomeVC")
                self.present(vc, animated: true, completion: nil)
                
            })
        }
    }
    
}

