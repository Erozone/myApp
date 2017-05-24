//
//  OrdersViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 19/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class OrdersViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    //MARK:- Collection View DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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

    @IBAction func cancelBtnPressed(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func doneBtnPressed(segue: UIStoryboardSegue){
        
        if let orderDetailVC = segue.source as? OrderDetailViewController{
            print("Sucessfully Get back")
        }
        
    }
    
}
