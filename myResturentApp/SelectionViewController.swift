//
//  SelectionViewController.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 24/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func CustomerBtn(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomerLoginVC")
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func RestaurentBtn(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
        self.present(vc, animated: true, completion: nil)
        
    }
   
    
    
}
