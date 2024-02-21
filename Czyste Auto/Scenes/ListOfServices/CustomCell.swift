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


class CellInListOfServices: CustomCell {
    let cartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "cart"), for: .normal)

        return button
    }()
    
    
    @objc private func didTapShoppingBasket() {
        
        cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)

        
        guard let tableView = superview as? UITableView,
              let indexPath = tableView.indexPath(for: self),
              let cleanCarViewController = tableView.delegate as? CleanCarViewController
        else {
            return
        }
        

        
        let viewModel = cleanCarViewController.viewModel
        
        let selectedService = cleanCarViewController.isSearching ? cleanCarViewController.filteredServices[indexPath.row] : viewModel.services[indexPath.row]
        let service = viewModel.services.first { $0.name == selectedService.name}
        
        guard let serviceToInsert = service else {return}
        
        let result = viewModel.selectedServices.insert(serviceToInsert)
        
        if result.inserted == false {
            VibrationManager.Vibration.error.vibrate()
            let alert = UIAlertController(title: "Uuupss", message: "Nie możesz dwukrotnie dodać tego do koszyka", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Rozumiem", style: .default, handler: nil))
            cleanCarViewController.present(alert, animated: true)
        } else {
            VibrationManager.Vibration.light.vibrate()

            cleanCarViewController.delegate?.didChangeServices(viewModel.selectedServices.count)
        }
        
        print("Selected services: \(viewModel.selectedServices)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
             self.cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
         }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addSubview(cartButton)
        accessoryView = cartButton
        
        NSLayoutConstraint.activate([
              
            cartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cartButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        cartButton.addTarget(self, action: #selector(didTapShoppingBasket), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
