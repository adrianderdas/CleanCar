//
//  OrdersViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit

class OrdersViewController: UIViewController {

    
  
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        let titleLabel = UILabel()
        titleLabel.text = "adad"
        //title = "Koszyk"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.titleView = titleLabel

    }
}
