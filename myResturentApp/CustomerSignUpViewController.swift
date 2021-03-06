//
//  CustomerSignUpViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 24/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class CustomerSignUpViewController: UIViewController ,UITextFieldDelegate{

    //MARK:- Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    
    func customizeView(){
        nameTextField = nameTextField.makeModTF(textFieldName: nameTextField, placeHolderName: "Name")
        emailTextField = emailTextField.makeModTF(textFieldName: emailTextField, placeHolderName: "Email")
        passwordTextField = passwordTextField.makeModTF(textFieldName: passwordTextField, placeHolderName: "Password")
        addressTextField = addressTextField.makeModTF(textFieldName: addressTextField, placeHolderName: "Address")
        phoneNumberTextField = phoneNumberTextField.makeModTF(textFieldName: phoneNumberTextField, placeHolderName: "Phone Number")
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        addressTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        self.hideKeyboardWhenTappedAround()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        if let name = nameTextField.text,let email = emailTextField.text,let password = passwordTextField.text,let address = addressTextField.text,let phone = phoneNumberTextField.text{
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                
                if error != nil{
                    print(error as Any)
                    return
                }
                
                let location = "Default Location"
                
                if let uid = user?.uid{
                    let databaseRef = FIRDatabase.database().reference().child("Customers").child(uid)
                    
                    let values = ["CustomerName":name,"CustomerEmail":email,"CustomerLocation":location,"CustomerAddress":address,"CustomerPhoneNumber":phone,"CustomerID":uid]
                    
                    databaseRef.updateChildValues(values)
                    
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
        }
    }

}
