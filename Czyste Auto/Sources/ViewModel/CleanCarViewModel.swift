//
//  CleanCarViewModel.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 24/09/2023.
//

import UIKit

class CleanCarViewModel {
    
    var filteredServices: [Service] = []
    
    let services = [
        Service(name:"Mycie silnika", image: "engine", price: 149),
        Service(name:"Mycie standardowe", image: "standard_wash", price: 99),
        Service(name:"Mycie podlogi", image: "car_floor", price: 79),
        Service(name:"Mycie felg", image: "wheel", price: 49),
        Service(name:"Woskowanie", image: "wosk", price: 220),
        Service(name:"Powłoka ceramiczna", image: "ceramic", price: 750),
        Service(name:"Odkurzanie wnętrza", image: "vacuum", price: 49),
        Service(name:"Mycie sufitki", image: "ceiling", price: 137)
    ]
    
    var selectedServices: Set<Service> = [] {
        didSet {
            saveServices(selectedServices)
            print("salectedServices saved: \(selectedServices)")
        }
    }
    
    func saveServices(_ services: Set<Service>) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Array(services)) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedServices")
        }
    }
    
    func loadServices() -> Set<Service>? {
        let defaults = UserDefaults.standard
        if let savedServices = defaults.object(forKey: "SavedServices") as? Data {
            let decoder = JSONDecoder()
            if let loadedServices = try? decoder.decode(Array<Service>.self, from: savedServices) {
                return Set(loadedServices)
            }
        }
        return nil
    }


}
