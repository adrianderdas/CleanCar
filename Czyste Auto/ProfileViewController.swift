//
//  ProfileViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.clipsToBounds = true
        view.backgroundColor = .systemBackground

        title = "Profil"
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
//
//        let titleLabel = UILabel()
//        titleLabel.text = title
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
//        titleLabel.sizeToFit()
//        titleLabel.textAlignment = .left
//        titleLabel.frame.origin.y = 10
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
//

        if let customImage = UIImage(systemName: "gearshape") {
            let customButton = UIBarButtonItem(image: customImage, style: .plain, target: self, action: #selector(didTapSettings))
            navigationItem.rightBarButtonItem = customButton
            navigationItem.rightBarButtonItem?.tintColor = UIColor.label
            
        }
    }
    
    
    @objc func didTapSettings() {
        
        print("User logged in")
        let vc = SettingsViewController()
        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc, animated: false)
    }
}


