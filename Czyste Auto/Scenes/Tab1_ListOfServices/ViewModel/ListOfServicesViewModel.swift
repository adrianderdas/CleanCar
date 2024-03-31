//
//  ListOfServicesViewModel.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 24/09/2023.
//

import UIKit
import Alamofire

class ListOfServicesViewModel {
    

    var items: [DownloadedService] = []

    
    var selectedServices: Set<DownloadedService> = [] {
        didSet {
            saveServices(selectedServices)
            print("salectedServices saved: \(selectedServices)")
        }
    }
    
    func saveServices(_ services: Set<DownloadedService>) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Array(services)) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedServices")
        }
    }
    
    func loadServices() -> Set<DownloadedService>? {
        let defaults = UserDefaults.standard
        if let savedServices = defaults.object(forKey: "SavedServices") as? Data {
            let decoder = JSONDecoder()
            if let loadedServices = try? decoder.decode(Array<DownloadedService>.self, from: savedServices) {
                return Set(loadedServices)
            }
        }
        return nil
    }

    var onServicesFetchedCallback: (() -> Void)?

    func fetchServices() {
        AF.request("http://192.168.1.100:3000/services")
            .validate()
            .responseDecodable(of: ServicesResponse.self) { [weak self] response in
                
                switch response.result {
                case .success(let serviceResponse):
                    self?.items = serviceResponse.all
                    
                    self?.onServicesFetchedCallback?()
                    
                case .failure(let error):
                    print("Wystąpił błąd: \(error)")
                }
            }
    }
}
