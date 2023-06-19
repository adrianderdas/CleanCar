//
//  TabBarController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit

class TabBarController: UITabBarController, CleanCarViewControllerDelegate, OrdersViewControllerDelegate {

    let defaults = UserDefaults.standard
    
    let cleanCarViewController = CleanCarViewController()

    var cartValue: Int = 0
    
    func didChangeServices(_ count: Int) {
        print("Func Did change services activated")
        cartValue = count
        updateBadgeValue()
        print("Func Did change services activated")
    }
    
    func updateBadgeValue() {
        
        if let tabBarItems = tabBar.items {
            let thirdBarItem = tabBarItems[2]
            print("cartCount: \(cartValue)")
            thirdBarItem.badgeValue = "\(cartValue)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        
        cartValue = cleanCarViewController.loadServices()?.count ?? 0
        updateBadgeValue()
        selectedIndex = 1
        view.backgroundColor = .systemBackground
    }
}

