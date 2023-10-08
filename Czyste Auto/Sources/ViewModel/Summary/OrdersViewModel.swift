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

}

protocol OrdersViewModelDelegate: AnyObject {
    func didChangeServices(_ count: Int)
}
