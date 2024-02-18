//
//  CustomCellForOrders.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 08/10/2023.
//

import UIKit

class CustomCellForOrders: UITableViewCell {
    let serviceImage = UIImageView()
    let serviceName = UILabel()
    let servicePrice = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("CustomCellForOrders initialised")
        addSubview(serviceImage)
        addSubview(serviceName)
        addSubview(servicePrice)
        
        serviceImage.frame = CGRect(x: 10, y: serviceImage.frame.height/2+10, width: 60, height: 60)
        serviceImage.layer.cornerRadius = serviceImage.frame.width/2
        serviceImage.layer.masksToBounds = true
        serviceName.frame = CGRect(x: serviceImage.frame.width+20, y: serviceImage.frame.height/2 - 10, width: 180, height: 30)
        servicePrice.frame = CGRect(x: serviceImage.width+220, y: serviceName.height+20, width: 80, height: 30)
        
        serviceImage.contentMode = .scaleAspectFit
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
