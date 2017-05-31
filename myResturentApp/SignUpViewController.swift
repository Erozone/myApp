//
//  SignUpViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 15/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate{
    
    //MARK:- Outlets
    
    @IBOutlet weak var restName: UITextField!
    @IBOutlet weak var resAddress: UITextField!
    @IBOutlet weak var resLocation: UITextField!
    @IBOutlet weak var resPincode: UITextField!
    @IBOutlet weak var resLandMark: UITextField!
    @IBOutlet weak var resPhone: UITextField!
    @IBOutlet weak var resEmail: UITextField!
    
    func customizeTextField(){
        restName = restName.makeModTF(textFieldName: restName, placeHolderName: "Restaurent Name")
        resAddress = resAddress.makeModTF(textFieldName: resAddress, placeHolderName: "Street Address")
        resLocation = resLocation.makeModTF(textFieldName: resLocation, placeHolderName: "Location")
        resPincode = resPincode.makeModTF(textFieldName: resPincode, placeHolderName: "Pincode")
        resLandMark = resLandMark.makeModTF(textFieldName: resLandMark, placeHolderName: "Landmark")
        resPhone = resPhone.makeModTF(textFieldName: resPhone, placeHolderName: "Phone")
        resEmail = resEmail.makeModTF(textFieldName: resEmail, placeHolderName: "Restaurent Email")
        restName.delegate = self
        resAddress.delegate = self
        resLocation.delegate = self
        resPincode.delegate = self
        resLandMark.delegate = self
        resPhone.delegate = self
        resEmail.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextField()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Actions
    
    @IBAction func nextScene(_ sender: DesignableButton) {
        self.performSegue(withIdentifier: "toNextScene", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNextScene",let destination = segue.destination as? FinalSignUpViewController{
            destination.restName = restName.text
            destination.resAddress = resAddress.text
            destination.resLocation = resLocation.text
            destination.resLandMark = resLandMark.text
            destination.resPincode = resPincode.text
            destination.resEmail = resEmail.text
            destination.resPhone = resPhone.text
        }
    }
    
}
