//
//  TabBarController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit

class TabBarController: UITabBarController, CleanCarViewControllerDelegate {

    let defaults = UserDefaults.standard
    
    let cleanCarViewController = CleanCarViewController()

    var selectedServices: Set<Service> = []
    
    func didAddServices(_ services: Set<Service>) {
        selectedServices = services
        updateBadgeValue()
    }
    
    func updateBadgeValue() {
        let cartCount = String(selectedServices.count)
        if let tabBarItems = tabBar.items {
            let thirdBarItem = tabBarItems[2]
            print("cartCount: \(cartCount)")
            thirdBarItem.badgeValue = cartCount
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedServices = cleanCarViewController.loadServices() ?? []
        updateBadgeValue()
        selectedIndex = 1
        view.backgroundColor = .systemBackground
    }
}

