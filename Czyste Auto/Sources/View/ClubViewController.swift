//
//  ClubViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit

class ClubViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "cześć"
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.text = "Brak ofert promocyjnych"
        return label
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        view.addSubview(label2)
        title = "Klub"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .red
        
        label.frame = CGRect(x: 0, y: 200, width: view.width, height: 20)
        label2.frame = CGRect(x: 20, y: label.bottom+100, width: view.width, height: 20)
    }
  
}


