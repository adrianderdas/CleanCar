//
//  SettingsViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit

class SettingsViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Ustawienia"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: view.frame.width   , height: view.frame.height)
        layer.colors = [UIColor.lightGray.cgColor, UIColor.blue.cgColor]
        view.layer.addSublayer(layer)
        navigationController?.navigationBar.tintColor = UIColor.label
        
    }
    
    

}
