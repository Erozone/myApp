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
    @IBOutlet weak var doneBtn: UIButton!
    
    var categoryOfDish:String!
    var food:FoodData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextField()
        doneBtn.isHidden = true
        navigationController?.delegate = self
        
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
        dishNameTF = makeModTF(textFieldName: dishNameTF, placeHolderName: "Enter Dish Name")
        dishPriceTF = makeModTF(textFieldName: dishPriceTF, placeHolderName: "Enter Dish Price")
        
        dishImageView.layer.cornerRadius = 70
        dishImageView.contentMode = .scaleAspectFill
        dishImageView.clipsToBounds = true
        dishImageView.backgroundColor = UIColor.blue
        
        doneBtn.layer.cornerRadius = 25
        
    }
    
    func makeModTF(textFieldName:UITextField,placeHolderName: String)->UITextField{
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        
        textFieldName.layer.cornerRadius = 20
        textFieldName.layer.borderColor = UIColor.black.cgColor
        textFieldName.layer.borderWidth = 1
        textFieldName.leftView = paddingView
        textFieldName.leftViewMode = .always
        textFieldName.attributedPlaceholder = NSAttributedString(string: placeHolderName, attributes: [NSForegroundColorAttributeName: UIColor.black,NSFontAttributeName : UIFont(name: "Roboto", size: 18)!])
        textFieldName.layer.masksToBounds = false
        textFieldName.delegate = self
        return textFieldName
    }
    
    @IBAction func imgPickButton(_ sender: UIButton){
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
    }
    
    //Persist the Data to the given Food Category and Dismiss the ViewController
    @IBAction func doneBtnPressed(_ sender: UIButton){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveFood"{
            
        }
    }
}


