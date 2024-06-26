//
//  TabBarController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit

class TabBarController: UITabBarController, ListOfServicesViewControllerDelegate, CartViewControllerDelegate {
    
    private let listOfServicesViewModel = ListOfServicesViewModel()

    let defaults = UserDefaults.standard
    
    let listOfServicesViewController = ListOfServicesViewController()

    var cartValue: Int = 0
    
    func didChangeServices(_ count: Int) {
        cartValue = count
        updateBadgeValue()
        print("Func Did change services activated")
    }
    
    func updateBadgeValue() {
        
        if let tabBarItems = tabBar.items {
            let thirdBarItem = tabBarItems[1]
            //print("cartCount: \(cartValue)")
            
            if cartValue == 0{
                thirdBarItem.badgeValue = nil
            } else {
                thirdBarItem.badgeValue = "\(cartValue)"

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.isTranslucent = false
        
        cartValue = listOfServicesViewModel.loadServices()?.count ?? 0
        updateBadgeValue()
        selectedIndex = 0
        view.backgroundColor = .systemBackground
        
        FirebaseService.shared.getData()
        
    }
}

