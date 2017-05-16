//
//  FoodCollectionViewCell.swift
//  myResturentApp
//
//  Created by Mohit Kumar on 16/05/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    
    var foodImageView:UIImageView!
    var addButton:UIButton!
    var foodName:UILabel!
    var foodPrice:UILabel!
    var dividerLine:UIView!
    var containerView:UIView!
    var isHomeView = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        let width = contentView.frame.width*0.25
        let height = contentView.frame.height
        let offset = CGFloat(15)
        foodImageView = UIImageView(frame: CGRect(x: offset-10, y: offset-10, width: width, height: width))
        foodImageView.contentMode = .scaleAspectFill
        foodImageView.clipsToBounds = true
        foodImageView.layer.cornerRadius = width / 2
        contentView.addSubview(foodImageView)
        
        dividerLine = UIView()
        dividerLine.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        contentView.addSubview(dividerLine)
        
        addContraintsWithFormat(format: "H:|-\(width+10)-[v0(1)]", views: dividerLine)
        addContraintsWithFormat(format: "V:|-5-[v0]|", views: dividerLine)
        
        containerView = UIView()
//        containerView.backgroundColor = UIColor.brown
        contentView.addSubview(containerView)
        
        addContraintsWithFormat(format: "H:|-\(width+offset)-[v0]|", views: containerView)
        addContraintsWithFormat(format: "V:|-\(offset-5)-[v0(\(height))]-\(offset-5)-|", views: containerView)
        
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY , relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)) //This will be used to center align the view
        
        foodName = UILabel()
        foodName.font = UIFont(name: "Roboto", size: 18)
//        foodName.backgroundColor = UIColor.blue
        containerView.addSubview(foodName)
        
        foodPrice = UILabel()
        foodPrice.font = UIFont(name: "Roboto", size: 18)
//        foodPrice.backgroundColor = UIColor.blue
        containerView.addSubview(foodPrice)
        
        addButton = UIButton()
        addButton.backgroundColor = UIColor.black
        addButton.layer.cornerRadius = 20
        containerView.addSubview(addButton)
        
        addContraintsWithFormat(format: "H:|-5-[v0]-\(width-2*offset+5)-|", views: foodName)
        addContraintsWithFormat(format: "V:|-5-[v0(\(height*0.40))]", views: foodName)
        
        addContraintsWithFormat(format: "H:|-5-[v0]-\(width+3*offset)-|", views: foodPrice)
        addContraintsWithFormat(format: "V:|-\((5+height*0.40+5))-[v0(\(height*0.40))]", views: foodPrice)
        
        addContraintsWithFormat(format: "H:|-\(2*width+offset)-[v0(40)]|", views: addButton)
        addContraintsWithFormat(format: "V:|-\(offset)-[v0(40)]", views: addButton)
        addConstraint(NSLayoutConstraint(item: addButton, attribute: .centerY , relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        if(isHomeView == false){
            addButton.isHidden = true
        }else{
            addButton.isHidden = false
        }
        
    }
}

extension FoodCollectionViewCell{
    func addContraintsWithFormat(format: String,views : UIView...){
        var viewsDictionary = [String:UIView]()
        for(index,view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
