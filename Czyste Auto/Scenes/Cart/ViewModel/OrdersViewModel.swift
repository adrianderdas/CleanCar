//
//  OrdersViewModel.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 08/10/2023.
//

import Foundation

class CartViewModel {
    
    weak var delegate: CartViewModelDelegate?
    
    func calculateTotalPrice(_ selectedServices: [DownloadedService]) -> Float {
        let totalPrice = selectedServices.reduce(0) { $0 + $1.price}
        return totalPrice
    }
    
    func checkIsUserSelectedAnyoneService(_ selectedServices: [DownloadedService]) -> Bool {
        if selectedServices.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func loadCartItemsFromUserDefaults() -> Any? {
        guard let data = UserDefaults.standard.data(forKey: "SavedServices") else {
            print("No data")
            return nil
        }

        do {let savedServices: Any
            savedServices = try JSONDecoder().decode([DownloadedService].self, from: data)
            
            print("userdefaults import in orders: \(savedServices)")
            return savedServices
        } catch {
            print("error decoding selectedServices: \(error)")
            return nil
        }
    }
    
    func saveNewServices(_ selectedServices: [DownloadedService]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(selectedServices) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedServices")
        }
    }
    
    

}

protocol CartViewModelDelegate: AnyObject {
    func didChangeServices(_ count: Int)
}
