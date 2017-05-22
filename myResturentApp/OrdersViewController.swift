//
//  OrdersViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 19/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseAuth

class OrdersViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var handle: FIRAuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

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
    
    //MARK:- Collection View DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCell", for: indexPath)
        
        return cell
    }

    @IBAction func logoutBtn(_sender:UIButton){
        
        do{
            try FIRAuth.auth()?.signOut()
            print("Logout the User")
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
            self.present(vc, animated: true, completion: nil)
            
        }catch let err as NSError{
            print(err.localizedDescription)
        }
    }

}
