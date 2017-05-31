//
//  AddFoodViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 16/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

class AddFoodViewController: UIViewController,UITextFieldDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    //MARK:- Outlets
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameTF: UITextField!
    @IBOutlet weak var dishPriceTF: UITextField!
    @IBOutlet weak var uploadBtn: UIButton!
    
    var categoryOfDish:String!
    var food:FoodData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextField()
        navigationController?.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
    }

    //Picks the select image and set it to imageView

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            dishImageView.image = pickedImage
            dishImageView.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    func customizeTextField(){
        dishNameTF = dishNameTF.makeModTF(textFieldName: dishNameTF, placeHolderName: "Enter Dish Name")
        dishPriceTF = dishPriceTF.makeModTF(textFieldName: dishPriceTF, placeHolderName: "Enter Dish Price")
        
    }
    
    @IBAction func imgPickButton(_ sender: UIButton){
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
    }
    
    //Persist the Data to the given Food Category and Dismiss the ViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveFood"{
            
        }
    }
}


