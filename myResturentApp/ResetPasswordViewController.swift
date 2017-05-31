//
//  ResetPasswordViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 19/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResetPasswordViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var resetEmailTF:UITextField!
    
    var isCustomer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextField()
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func customizeTextField(){
        resetEmailTF = resetEmailTF.makeModTF(textFieldName: resetEmailTF, placeHolderName: "Email Address")
        resetEmailTF.delegate = self
    }
    
    func displayAlert(title: String,displayError: String,performThisCode:Bool){
        let alert = UIAlertController(title: title, message: displayError, preferredStyle: UIAlertControllerStyle.alert)
//        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (alertAction) in
            if performThisCode == true{
                if self.isCustomer == false{
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
                    self.present(vc,animated: true, completion: nil)
                }else{
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomerLoginVC")
                    self.isCustomer = false
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func resetBtnPressed(_ sender:UIButton){
        var title = ""
        var message = ""
        
        if let email = resetEmailTF.text,resetEmailTF.text != ""{
            FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
                if error != nil{
                    title = "Error"
                    message = (error?.localizedDescription)!
                    self.displayAlert(title: title, displayError: message,performThisCode: false)
                }
                else{
                    title = "Sucess"
                    message = "Password reset email sent"
                    self.resetEmailTF.text = ""
                    self.displayAlert(title: title, displayError: message,performThisCode: true)
                }
                
            })
        }else{
            title = "Email Field is empty"
            message = "Please enter email address"
            displayAlert(title: title, displayError: message,performThisCode: false)
        }
    }
    
}
