//
//  OrdersViewModel.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 08/10/2023.
//

import Foundation

class OrdersViewModel {
    
    weak var delegate: OrdersViewModelDelegate?
    
    

    func calculateTotalPrice(_ selectedServices: [Service]) -> Int {
        let totalPrice = selectedServices.reduce(0) { $0 + $1.price}
        return totalPrice
    }
    
    func checkIsUserSelectedAnyoneService(_ selectedServices: [Service]) -> Bool {
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
            savedServices = try JSONDecoder().decode([Service].self, from: data)
            
            print("userdefaults import in orders: \(savedServices)")
            return savedServices
        } catch {
            print("error decoding selectedServices: \(error)")
            return nil
        }
    }
    
    func saveNewServices(_ selectedServices: [Service]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(selectedServices) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedServices")
        }
    }
    
    

}

protocol OrdersViewModelDelegate: AnyObject {
    func didChangeServices(_ count: Int)
}
