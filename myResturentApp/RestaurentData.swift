//
//  RestaurentData.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 18/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import Foundation
import UIKit

public class RestaurentData: NSObject,NSCoding{
    
    var Restaurent_Name:String?
    var Restaurent_Address:String?
    var Restaurent_Location:String?
    var Restaurent_Pincode:String?
    var Restaurent_Phone:String?
    var Restaurent_Landmark:String?
    var Restaurent_Email:String?
    var Password:String?
    var Re_Password:String?
    var Owner_Email:String?
    var Profile_Image:String?
    var UID:String?
    
    init(Restaurent_Name: String?,Restaurent_Address: String,Restaurent_Location: String ,Restaurent_Pincode: String,Restaurent_Phone: String,Restaurent_Landmark: String,Restaurent_Email: String ,Password: String,Re_Password: String,Owner_Email: String ,Profile_Image: String,UID: String) {
        self.Restaurent_Name = Restaurent_Name
        self.Restaurent_Address = Restaurent_Address
        self.Restaurent_Location = Restaurent_Location
        self.Restaurent_Pincode = Restaurent_Pincode
        self.Restaurent_Phone = Restaurent_Phone
        self.Restaurent_Landmark = Restaurent_Landmark
        self.Restaurent_Email = Restaurent_Email
        self.Password = Password
        self.Re_Password = Re_Password
        self.Owner_Email = Owner_Email
        self.Profile_Image = Profile_Image
        self.UID = UID
        
    }
    
    override init() {
        
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        let Restaurent_Name = aDecoder.decodeObject(forKey: "Restaurent_Name") as! String
        let Restaurent_Address = aDecoder.decodeObject(forKey: "Restaurent_Address") as! String
        let Restaurent_Location = aDecoder.decodeObject(forKey: "Restaurent_Location") as! String
        let Restaurent_Pincode = aDecoder.decodeObject(forKey: "Restaurent_Pincode") as! String
        let Restaurent_Phone = aDecoder.decodeObject(forKey: "Restaurent_Phone") as! String
        let Restaurent_Landmark = aDecoder.decodeObject(forKey: "Restaurent_Landmark") as! String
        let Restaurent_Email = aDecoder.decodeObject(forKey: "Restaurent_Email") as! String
        let Password = aDecoder.decodeObject(forKey: "Password") as! String
        let Re_Password = aDecoder.decodeObject(forKey: "Re_Password") as! String
        let Owner_Email = aDecoder.decodeObject(forKey: "Owner_Email") as! String
        let Profile_Image = aDecoder.decodeObject(forKey: "Profile_Image") as! String
        let UID = aDecoder.decodeObject(forKey: "UID") as! String
        self.init(Restaurent_Name: Restaurent_Name, Restaurent_Address: Restaurent_Address, Restaurent_Location: Restaurent_Location, Restaurent_Pincode: Restaurent_Pincode, Restaurent_Phone: Restaurent_Phone, Restaurent_Landmark:Restaurent_Landmark, Restaurent_Email: Restaurent_Email, Password: Password, Re_Password: Re_Password, Owner_Email: Owner_Email, Profile_Image: Profile_Image, UID: UID)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(Restaurent_Name, forKey: "Restaurent_Name")
        aCoder.encode(Restaurent_Address, forKey: "Restaurent_Address")
        aCoder.encode(Restaurent_Location, forKey: "Restaurent_Location")
        aCoder.encode(Restaurent_Pincode, forKey: "Restaurent_Pincode")
        aCoder.encode(Restaurent_Phone, forKey: "Restaurent_Phone")
        aCoder.encode(Restaurent_Landmark, forKey: "Restaurent_Landmark")
        aCoder.encode(Restaurent_Email, forKey: "Restaurent_Email")
        aCoder.encode(Password, forKey: "Password")
        aCoder.encode(Re_Password, forKey: "Re_Password")
        aCoder.encode(Owner_Email, forKey: "Owner_Email")
        aCoder.encode(Profile_Image, forKey: "Profile_Image")
        aCoder.encode(UID, forKey: "UID")
    }

}
