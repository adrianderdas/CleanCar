//
//  ZeroViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 19/06/2023.
//

import UIKit

class ZeroViewController: UIViewController {
    private let viewModel = ZeroViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        validateAuth()
    }

    func validateAuth() {
        if viewModel.isUserLogIn() {
            runDashboard()
        } else {
            runLoginVC()
        }
    }
        
    func runDashboard() {
        performSegue(withIdentifier: "run", sender: nil)
        print("User logged in")
    }
    
    func runLoginVC() {
        let vc = LoginViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false)
        print("User no logged in")
    }
}
