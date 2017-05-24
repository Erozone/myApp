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
    @IBOutlet weak var resetBtnOutlet: DesignableButton!
    
    var isCustomer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func customizeTextField(){
        resetEmailTF = resetEmailTF.makeModTF(textFieldName: resetEmailTF, placeHolderName: "Email Address")
        resetEmailTF.delegate = self
    }
    
    func displayAlert(title: String,displayError: String){
        let alert = UIAlertController(title: title, message: displayError, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetBtnPressed(_ sender:UIButton){
        var title = ""
        var message = ""
        
        if let email = resetEmailTF.text{
            FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
                if error != nil{
                    title = "Error"
                    message = (error?.localizedDescription)!
                }
                else{
                    title = "Sucess"
                    message = "Password reset email sent"
                }
                
                self.displayAlert(title: title, displayError: message)
                self.resetEmailTF.text = ""
                if self.isCustomer == false{
                    self.performSegue(withIdentifier: "toBackLogin", sender: self)
//                    self.dismiss(animated: true, completion: nil)
                }else{
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomerLoginVC")
                    self.present(vc, animated: true, completion: nil)
                }
                
                
            })
        }else{
            title = "Email Field is empty"
            message = "Please enter email address"
            displayAlert(title: title, displayError: message)
        }
    }
    
}
