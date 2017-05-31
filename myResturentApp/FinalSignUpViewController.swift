//
//  FinalSignUpViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 15/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseStorage



class FinalSignUpViewController: UIViewController,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    //MARK:- Outlet
    
    @IBOutlet weak var ownerEmail: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    @IBOutlet weak var restImageView: UIImageView!
    
    //MARK:- Properties
    
    var restName:String!
    var resAddress:String!
    var resLocation:String!
    var resPincode:String!
    var resLandMark:String!
    var resPhone:String!
    var resEmail:String!
    static var counter = 1
    
    var foodCategory = "Default Category"
    var foodName = "Default Food Name"
    var foodPrice = "Default Food Price"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextField()
        self.hideKeyboardWhenTappedAround()
    }
    
    //Picks the select image and set it to imageView
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            restImageView.image = pickedImage
            restImageView.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func customizeTextField(){
        ownerEmail = ownerEmail.makeModTF(textFieldName: ownerEmail, placeHolderName: "Enter personal Email")
        passwordTF = passwordTF.makeModTF(textFieldName: passwordTF, placeHolderName: "Password")
        rePassword = rePassword.makeModTF(textFieldName: rePassword, placeHolderName: "Re-Password")
        ownerEmail.delegate = self
        passwordTF.delegate = self
        rePassword.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func uploadBtnPressed(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
    }
    
    @IBAction func submitBtnPressed(_ sender:UIButton){
        
        if let email = ownerEmail.text,let passwordString = passwordTF.text,let rePassword = rePassword.text,let name = restName,let address = resAddress,let location = resLocation,let landmark = resLandMark,let pincodeString = resPincode,let phoneNumber = resPhone,let resEmailString = resEmail{
            FIRAuth.auth()?.createUser(withEmail: email, password: passwordString, completion: { (user:FIRUser?, error) in
                
                if(error != nil){
                    print(error as Any)
                    return
                }
                
                //Save Restaurent Image
                var data = NSData()
                if let image = self.restImageView.image{
                    data = UIImageJPEGRepresentation(image,0.5)! as NSData
                    
                    let storageRef = FIRStorage.storage().reference().child("\(self.restName!).png")
                    
                    storageRef.put(data as Data, metadata: nil, completion: { (metadata, error) in
                        if error != nil{
                            print(error as Any)
                            return
                        }
                        
                        if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                            
                            if let uid = user?.uid{
                                let values:[String:Any] = ["Restaurent_Name":name,"Restaurent_Address":address,"Restaurent_Location": location,"Restaurent_Landmark":landmark,"Restaurent_Pincode":pincodeString,"Restaurent_Phone":phoneNumber,"Restaurent_Email":resEmailString,"Owner_Email":email,"Password":passwordString,"Re_Password":rePassword,"Profile_Image":profileImageUrl,"UID":uid]
                                self.registerUserIntoDatabaseWithUid(uid: uid, values: values)
                            }
                        }
                        print(metadata as Any)
                    })
                }
            })
        }
    }
    
    private func registerUserIntoDatabaseWithUid(uid:String,values: [String:Any]){
        //Sucessfully authenticated user
        
            let databaseRef = FIRDatabase.database().reference()
            let childRef = databaseRef.child("Restaurents").child(uid)
        
            childRef.updateChildValues(values, withCompletionBlock: { (err, databaseRef) in
                
                if(err != nil){
                    print(err as Any)
                    return
                }
                
                print("Saved user successfully into the database")
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
                self.present(vc, animated: true, completion: nil)
            })
    }
    
}
