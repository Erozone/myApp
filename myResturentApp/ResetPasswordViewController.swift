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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func customizeTextField(){
        resetEmailTF = makeModTF(textFieldName: resetEmailTF, placeHolderName: "Email Address")
    }

    func makeModTF(textFieldName:UITextField,placeHolderName: String)->UITextField{
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        
        textFieldName.layer.cornerRadius = 20
        textFieldName.layer.borderColor = UIColor.red.cgColor
        textFieldName.layer.borderWidth = 1
        textFieldName.leftView = paddingView
        textFieldName.leftViewMode = .always
        textFieldName.attributedPlaceholder = NSAttributedString(string: placeHolderName, attributes: [NSForegroundColorAttributeName: UIColor.black,NSFontAttributeName : UIFont(name: "Roboto", size: 18)!])
        textFieldName.layer.masksToBounds = false
        textFieldName.delegate = self
        return textFieldName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        customizeTextField()
        // Dispose of any resources that can be recreated.
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
                self.performSegue(withIdentifier: "toBackLogin", sender: self)
                
            })
        }
        
    }
    
}
