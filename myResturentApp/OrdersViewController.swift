//
//  OrdersViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 19/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseAuth

class OrdersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutBtn(_sender:UIButton){
        if FIRAuth.auth()?.currentUser != nil{
            do{
                try FIRAuth.auth()?.signOut()
                print("Logout the User")
                self.performSegue(withIdentifier: "toLoginByLogout", sender: self)
                
            }catch let err as NSError{
                print(err.localizedDescription)
            }
        }
        
    }

}
