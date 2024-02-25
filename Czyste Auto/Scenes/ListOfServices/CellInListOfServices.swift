//
//  File.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 21/02/2024.
//

import Foundation
import UIKit

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
