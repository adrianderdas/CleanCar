//
//  TabBarController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit

class TabBarController: UITabBarController{


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 1
        view.backgroundColor = .systemBackground
        
        // Ustawienie badgeValue na elemencie 3
        if let tabBarItems = tabBar.items, tabBarItems.count >= 3 {
            let thirdTabBarItem = tabBarItems[2]
            thirdTabBarItem.badgeValue = "1"
        }
    }

}

