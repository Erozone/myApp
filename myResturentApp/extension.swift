//
//  extension.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 22/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

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
