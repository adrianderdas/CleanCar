//
//  BaseCell.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 23/06/2023.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell {
    let serviceImage = UIImageView()
    let serviceName = UILabel()
    let servicePrice = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(serviceImage)
        addSubview(serviceName)
        addSubview(servicePrice)
        
        serviceImage.frame = CGRect(x: 10, y: serviceImage.frame.height/2, width: 100, height: 100)
        serviceName.frame = CGRect(x: serviceImage.width+10, y: 10, width: 120, height: 30)
        servicePrice.frame = CGRect(x: serviceImage.width+10, y: serviceName.height+20, width: 80, height: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
