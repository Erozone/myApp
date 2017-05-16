//
//  RestaurentHomeViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 15/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import MapKit

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
