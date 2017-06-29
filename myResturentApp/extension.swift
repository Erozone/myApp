//
//  extension.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 22/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
let FOOD_ORDER_NOTIFICATION = NSNotification.Name("FoodOrderNotification")
let ORDER_FOOD_KEY = "foods"
var restaurentID = ""
var restaurentImageURL = ""
var restaurent : RestaurentData? = nil
var customerID: String? = nil
var restaurentIDKey = "restaurentID"

extension UIImageView{
    
    func loadImagesUsingCacheFromURLString(url:String){
        if let url = URL(string: url){
            
            //Get ImageFrom Cache
            if let cacheImage = imageCache.object(forKey: url as AnyObject) as? UIImage{
                print("Images from Cache")
                self.image = cacheImage
                return
            }
            
            //Download Imgaes from firebase
            
            print("Images from Firebase")
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil{
                    print(error as Any)
                    return
                }
                
                DispatchQueue.main.async {
                    if let downloadedImages = UIImage(data: data!){
                        
                        imageCache.setObject(downloadedImages, forKey: url as AnyObject)
                        self.image = downloadedImages
                    }
                }
                
            }).resume()
        }
    }
    
}

extension UITextField{
    
    func makeModTF(textFieldName:UITextField,placeHolderName: String)->UITextField{
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        
        textFieldName.layer.cornerRadius = 20
        textFieldName.layer.borderColor = UIColor.white.cgColor
        textFieldName.layer.borderWidth = 1
        textFieldName.leftView = paddingView
        textFieldName.leftViewMode = .always
        textFieldName.attributedPlaceholder = NSAttributedString(string: placeHolderName, attributes: [NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName : UIFont(name: "Roboto", size: 18)!])
        textFieldName.layer.masksToBounds = false
        return textFieldName
    }
    
}


extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
