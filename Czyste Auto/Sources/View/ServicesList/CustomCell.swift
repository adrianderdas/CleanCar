//
//  CustomCell.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 07/10/2023.
//

import UIKit

class CustomCell: UITableViewCell {
    

    let serviceImage = UIImageView()
    let serviceName = UILabel()
    let servicePrice = UILabel()
    
    let cartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("CustomCell initialised")
        addSubview(serviceImage)
        addSubview(serviceName)
        addSubview(servicePrice)
        addSubview(cartButton)
        accessoryView = cartButton
        
        serviceImage.frame = CGRect(x: 10, y: serviceImage.frame.height/2, width: 100, height: 100)
        serviceImage.layer.cornerRadius = serviceImage.frame.width/2
        serviceImage.layer.masksToBounds = true
        serviceName.frame = CGRect(x: serviceImage.width+20, y: 10, width: 150, height: 30)
        servicePrice.frame = CGRect(x: serviceImage.width+20, y: serviceName.height+20, width: 80, height: 30)
        cartButton.frame = CGRect(x: 200, y: 50, width: 50, height: 50)
        cartButton.addTarget(self, action: #selector(didTapShoppingBasket), for: .touchUpInside)
    }
    
    @objc private func didTapShoppingBasket() {
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
            let alert = UIAlertController(title: "Uuupss", message: "Nie możesz dwukrotnie dodać tego do koszyka", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Rozumiem", style: .default, handler: nil))
            cleanCarViewController.present(alert, animated: true)
        } else {
            cleanCarViewController.delegate?.didChangeServices(viewModel.selectedServices.count)
        }
        
        
        print("Selected services: \(viewModel.selectedServices)")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
