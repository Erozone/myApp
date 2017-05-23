//
//  OrderDetailViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 22/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class OrderDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    //MARK:- Outlets
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var customerAddress: UILabel!
    @IBOutlet weak var customerLocation: UILabel!
    @IBOutlet weak var foodTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "Roti"
        return cell
    }

}
