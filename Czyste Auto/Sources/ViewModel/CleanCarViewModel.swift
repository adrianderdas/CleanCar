//
//  CleanCarViewModel.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 24/09/2023.
//

import UIKit

class CleanCarViewModel {

    /// Function using for save services choosen by user to UserDefaults
    /// - parameter services: Set with choosen services
    func saveServices(_ services: Set<Service>) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Array(services)) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedServices")
        }
    }
    
    var selectedServices: Set<Service> = [] {
        didSet {
            saveServices(selectedServices)
            print("salectedServices saved: \(selectedServices)")
        }
    }

    @objc private func didTapShoppingBasket() {
        guard let tableView = superview as? UITableView,
              let indexPath = tableView.indexPath(for: self),
              let viewController = tableView.delegate as? CleanCarViewController else {
            return
        }
        
        // Dzieki temu podczas korzystania z searchBar nie jest gubiony indexPath
        let selectedService = viewController.isSearching ? viewController.filteredServices[indexPath.row] : viewController.services[indexPath.row]
        let service = viewController.services.first { $0.name == selectedService.name}
        
        guard let serviceToInsert = service else {return}
        
        let result = viewModel.selectedServices.insert(serviceToInsert)
        
        if result.inserted == false {
            let alert = UIAlertController(title: "Uuupss", message: "Nie możesz dwukrotnie dodać tego do koszyka", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Rozumiem", style: .default, handler: nil))
            viewController.present(alert, animated: true)
        } else {
            viewController.delegate?.didChangeServices(viewController.selectedServices.count)
        }
        //viewController.selectedServices.insert(service)
        
        print("Selected services: \(viewController.selectedServices)")
    }


}
