//
//  ProfileViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        cell.setUp(with: viewModel)
        return cell
    }
    
    //@IBOutlet var asdasdsad: UITableView!
    
   @IBOutlet var tableView: UITableView!
    var data = [ProfileViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       
        title = "Profil"
        navigationController?.navigationBar.prefersLargeTitles = true

        if let customImage = UIImage(systemName: "gearshape") {
            let customButton = UIBarButtonItem(image: customImage, style: .plain, target: self, action: #selector(didTapSettings))
            navigationItem.rightBarButtonItem = customButton
            navigationItem.rightBarButtonItem?.tintColor = UIColor.label
        }
        
        
        data.append(ProfileViewModel(viewModelType: .info,
                                     title: "Imię i nazwisko :",
                                     handler: nil))
        data.append(ProfileViewModel(viewModelType: .info,
                                     title: "Email :",
                                     handler: nil))
        data.append(ProfileViewModel(viewModelType: .logout,
                                     title: "Wyloguj się",
                                     handler: nil))
        
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    
    
    @objc func didTapSettings() {
        print("User tapped settings")
        let vc = SettingsViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: false)
    }
}


class ProfileTableViewCell: UITableViewCell {
    static let identifier = "ProfileTableViewCell"
    
    public func setUp(with viewModel: ProfileViewModel) {
        self.textLabel?.text = viewModel.title
        
        switch viewModel.viewModelType {
            
        case .info:
            textLabel?.textAlignment = .left
            selectionStyle = .none
            
        case .logout:
            textLabel?.textColor = .red
            textLabel?.textAlignment = .center
            
        }
    }
}




struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}

enum ProfileViewModelType {
    case info, logout
}

