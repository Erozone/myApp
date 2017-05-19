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

class RestaurentHomeViewController: UIViewController,CLLocationManagerDelegate {
    
    //MARK: - Outlet
    
    @IBOutlet weak var resImageView: UIImageView!
    @IBOutlet weak var resName: UILabel!
    @IBOutlet weak var resAddress: UILabel!
    @IBOutlet weak var resLandMark: UILabel!
    @IBOutlet weak var resPhone: UILabel!
    @IBOutlet weak var resLocationMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myLocation(latitude: 26.853750, longitude: 80.999117, placeName: "Spice Caves", comment: "Best Place for Foodies")
        
        checkIfUserIsLoggedIn()
    }
    
    func checkIfUserIsLoggedIn(){
        if FIRAuth.auth()?.currentUser?.uid == nil{
            print("Please Logout the User")
            return
        }
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("Restaurents").child(uid!).observe(.value, with: { (snapshot) in
            
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String:Any]{
                self.resName.text = dictionary["Restaurent Name"] as? String
                self.resAddress.text = dictionary["Restaurent Address"] as? String
                self.resLandMark.text = dictionary["Restaurent Landmark"] as? String
                self.resPhone.text = dictionary["Restaurent Phone"] as? String
                
                if let imageURLString = dictionary["Profile Image"] as? String{
                    let url = URL(string: imageURLString)
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if error != nil{
                            print(error)
                            return
                        }
                        
                        //This will add this thread to main queue
                        DispatchQueue.main.async {
                            self.resImageView.image = UIImage(data: data!)
                        }
                        
                    }).resume()
                }
            }
            
        }, withCancel: nil)
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
