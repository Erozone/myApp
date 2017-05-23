//
//  RestaurentHomeViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 15/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseDatabase

class Place{
    
    let latitude:CLLocationDegrees
    let longitude: CLLocationDegrees
    let placeName: String
    let comment: String
    
    init(lat:CLLocationDegrees,long:CLLocationDegrees,placeName:String,placeComment:String) {
        latitude = lat
        longitude = long
        self.placeName = placeName
        comment = placeComment
    }
}

let cacheData = NSCache<AnyObject, AnyObject>()

class RestaurentHomeViewController: UIViewController,CLLocationManagerDelegate {
    
    //MARK: - Outlet
    
    @IBOutlet weak var resImageView: UIImageView!
    @IBOutlet weak var resName: UILabel!
    @IBOutlet weak var resAddress: UILabel!
    @IBOutlet weak var resLandMark: UILabel!
    @IBOutlet weak var resPhone: UILabel!
    @IBOutlet weak var resLocationMapView: MKMapView!
    
    var handle: FIRAuthStateDidChangeListenerHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myLocation(latitude: 26.853750, longitude: 80.999117, placeName: "Spice Caves", comment: "Best Place for Foodies")
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        handle = FIRAuth.auth()?.addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
            
            print("THIS IS LOGIN USER DETAILS FROM RESTAURENT VC")
            
            if let user = user{
                print(user.email as Any)
                print("USER ID is \(user.uid)")
                self.loadDataFromDB(user: user)
            }
            
            print("END OF THE USER DETAILS")
            
            // [END_EXCLUDE]
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        FIRAuth.auth()?.removeStateDidChangeListener(handle!)
    }
    
    
    func loadDataFromDB(user:FIRUser){
            let uid = user.uid
            FIRDatabase.database().reference().child("Restaurents").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                print(snapshot)
                
                if let cacheDictionary = cacheData.object(forKey: uid as AnyObject) as? [String:Any]{
                    print("Getting Values Through Cache")
                    let restaurent = RestaurentData()
                    restaurent.setValuesForKeys(cacheDictionary)
                    self.setRestaurentViewValues(restaurent: restaurent)
                    return
                }
                
                
                
                if let dictionary = snapshot.value as? [String:Any]{
                    print("Getting Values Through Firebase")
                    
                    let restaurent = RestaurentData()
                    
                    cacheData.setObject(dictionary as AnyObject, forKey: uid as AnyObject)
                    restaurent.setValuesForKeys(dictionary)
                    self.setRestaurentViewValues(restaurent: restaurent)
                }
                
            }, withCancel: nil)
        }
    
    func setRestaurentViewValues(restaurent:RestaurentData){
        self.resName.text = restaurent.Restaurent_Name
        self.resAddress.text = restaurent.Restaurent_Address
        self.resLandMark.text = restaurent.Restaurent_Landmark
        self.resPhone.text = restaurent.Restaurent_Phone
        
        if let imageURLString = restaurent.Profile_Image{
            self.resImageView.loadImagesUsingCacheFromURLString(url: imageURLString)
        }
    }
    
    func handleLogout(){
        do{
            try FIRAuth.auth()?.signOut()
        }catch let error{
            print(error)
        }
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
        self.present(vc, animated: true, completion: nil)
    }
    
    func myLocation(latitude:CLLocationDegrees,longitude:CLLocationDegrees,placeName:String,comment:String){
        
        //Co-ordinates
        
        let placeLatitude:CLLocationDegrees = latitude
        let placeLongitude:CLLocationDegrees = longitude
        
        let coordinate = CLLocationCoordinate2D(latitude: placeLatitude, longitude: placeLongitude)
        
        //Span
        
        let letDelta:CLLocationDegrees = 0.010
        let longDelta:CLLocationDegrees = 0.010
        let mySpan = MKCoordinateSpan(latitudeDelta: letDelta, longitudeDelta: longDelta)
        
        let myRegion = MKCoordinateRegion(center: coordinate, span: mySpan)
        
        let annotation = MKPointAnnotation()
        annotation.title = placeName
        annotation.subtitle = comment
        annotation.coordinate = coordinate
        
        resLocationMapView.addAnnotation(annotation)
        resLocationMapView.setRegion(myRegion, animated: true)
    }
    
}
