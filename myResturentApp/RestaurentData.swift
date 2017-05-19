//
//  RestaurentData.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 18/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import Foundation
import UIKit

public class Restaurent{
    var restImage:UIImage?
    var restName:String?
    var restAddress:String?
    var restLocation:String?
    var restPincode:String?
    var restLandmark:String?
    var restPhoneNumber:String?
    var restMail:String?
    var restTiming:String?
    var restPersonalEmail:String?
    var restPassword:String?
    var restRePassword:String?
    var restMenu:Menu?
    
    init() {
        
    }
    
    init(image:UIImage,name:String,address:String,location:String,pincode:String,landmark:String,phoneNumber:String,restMail:String,timing:String,email:String,password:String,rePassword:String,menu:Menu) {
        self.restImage = image
        self.restName = name
        self.restAddress = address
        self.restLocation = location
        self.restPincode = pincode
        self.restLandmark = landmark
        self.restPhoneNumber = phoneNumber
        self.restMail = restMail
        self.restTiming = timing
        self.restPersonalEmail = email
        self.restPassword = password
        self.restRePassword = rePassword
        self.restMenu = menu
    }
    
}
