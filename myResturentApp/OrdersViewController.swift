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
    
    var handle: FIRAuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        handle = FIRAuth.auth()?.addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
            
            print("THIS IS LOGIN USER DETAILS")
            
            if let user = user{
                print(user.email as Any)
            }
            
            print("END OF THE USER DETAILS")
            
            // [END_EXCLUDE]
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        FIRAuth.auth()?.removeStateDidChangeListener(handle!)
    }

    @IBAction func logoutBtn(_sender:UIButton){
        
        do{
            try FIRAuth.auth()?.signOut()
            print("Logout the User")
            
            //THis will instantiate the current view controller two times
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
            self.present(vc, animated: true, completion: nil)
            
        }catch let err as NSError{
            print(err.localizedDescription)
        }
    }

}
