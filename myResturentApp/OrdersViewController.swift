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
import Firebase

class OrdersViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //MARK: - OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    var customerOrders = [String:[CustomerDetails]]()
    var customers = [Customers]()
    {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let restaurentId = UserDefaults.standard.value(forKey: restaurentIDKey) as? String{
            loadOrdersFromDatabase(restaurentId: restaurentId)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        print(customerOrders)

    }
    
    func loadOrdersFromDatabase(restaurentId:String){
        let databaseRef = FIRDatabase.database().reference()
        let ordersRef = databaseRef.child("Orders").child(restaurentId)
        
        ordersRef.observe(.childAdded, with: { (snapshot) in
            
            let userRef = databaseRef.child("Customers").child(snapshot.key)
            userRef.observeSingleEvent(of: .value, with: { (snap) in  // This will retrieve users from Database
                
                if let userDictionary = snap.value as? [String:String]{
                    let customer = Customers()
                    customer.setValuesForKeys(userDictionary)
                    self.customers.append(customer)
                }
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    //MARK:- Collection View DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCell", for: indexPath) as! mainOrdersCollectionViewCell
        
        let customer = customers[indexPath.row]
        if let name = customer.CustomerName{
            cell.gotAnOrderMsg.text = "You Got An Order From \(String(describing: name))"
        }else{
            cell.gotAnOrderMsg.text = "You Got An Order"
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.width, height: (self.view.frame.height*0.25))
//    }

    //MARK:- Actions
    
    @IBAction func logoutBtn(_sender:UIButton){
        
        do{
            try FIRAuth.auth()?.signOut()
            print("Logout the User")
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectionVC")
            self.present(vc, animated: true, completion: nil)
            
        }catch let err as NSError{
            print(err.localizedDescription)
        }
    }
    
    //MARK:- My Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailOrder",let destination = segue.destination as? OrderDetailViewController{
            if let cell = sender as? mainOrdersCollectionViewCell{
                if let indexPath = self.collectionView?.indexPath(for: cell){
                    let selectedRow = customers[indexPath.row]
                    destination.customer = selectedRow
                }
            }
        }
    }
    
    //MARK:- Actions

    @IBAction func cancelBtnPressed(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func doneBtnPressed(segue: UIStoryboardSegue){
        
        if let orderDetailVC = segue.source as? OrderDetailViewController{
            print("Sucessfully Get back")
        }
        
    }
    
}

class mainOrdersCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var gotAnOrderMsg: UILabel!
    
}
