//
//  CustomCell.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 07/10/2023.
//

import UIKit

class CustomCell: UITableViewCell {
    
    
    let serviceImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .red
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        
        return image
    }()

    let serviceName: UILabel = {
        let serviceTextTitle = UILabel()
        serviceTextTitle.translatesAutoresizingMaskIntoConstraints = false
        return serviceTextTitle
    }()
    
   
    let servicePrice: UILabel = {
        let serviceTextPrice = UILabel()
        serviceTextPrice.translatesAutoresizingMaskIntoConstraints = false
        return serviceTextPrice
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(serviceImage)
        addSubview(serviceName)
        addSubview(servicePrice)
   
        
        NSLayoutConstraint.activate([
            serviceImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            serviceImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            serviceImage.heightAnchor.constraint(equalToConstant: 80),
            serviceImage.widthAnchor.constraint(equalToConstant: 80),
            
            serviceName.leadingAnchor.constraint(equalTo: serviceImage.trailingAnchor, constant: 20),
            serviceName.topAnchor.constraint(equalTo: serviceImage.topAnchor, constant: 5),
            
            servicePrice.leadingAnchor.constraint(equalTo: serviceName.leadingAnchor),
            servicePrice.bottomAnchor.constraint(equalTo: serviceImage.bottomAnchor, constant: -5),
            

        ])
 
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
