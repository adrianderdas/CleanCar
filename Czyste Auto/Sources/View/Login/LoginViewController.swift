//
//  LoginViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 19/06/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
        
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Adres e-mail"
        field.keyboardType = .emailAddress
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        
        return field
    }()
    
    private let passwordFireld: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Hasło"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        field.isSecureTextEntry = true
        
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Zaloguj się", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "auto")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Utwórz konto"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        title = "Logowanie"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Rejestracja", style: .done, target: self, action: #selector(didTapRegister))
        
        loginButton.addTarget(self, action: #selector(loginButonTapped), for: .touchUpInside)
        
        
        emailField.delegate = self
        passwordFireld.delegate = self
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordFireld)
        scrollView.addSubview(loginButton)
        
        
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
        emailField.frame = CGRect(x: 30, y: imageView.bottom + 40, width: scrollView.width-60, height: 52)
        passwordFireld.frame = CGRect(x: 30, y: emailField.bottom + 10, width: scrollView.width-60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passwordFireld.bottom+40 , width: scrollView.width-60, height: 52)
    }
    
    @objc private func loginButonTapped() {
        emailField.resignFirstResponder()
        passwordFireld.resignFirstResponder()
        
        viewModel.email = emailField.text
        viewModel.password = passwordFireld.text
        
        activityIndicator.startAnimating()
        
        
        viewModel.login { [weak self] success, errorMessage in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
            }
            if success {
                self?.navigationController?.dismiss(animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: errorMessage, message: nil, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Popraw", style: .default)
                alertController.addAction(okAction)
                self?.present(alertController, animated: true, completion: nil)
            }
            
            
        }
    }
}
    
    
    extension LoginViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == emailField {
                passwordFireld.becomeFirstResponder()
            } else if textField == passwordFireld {
                textField.resignFirstResponder()
            }
            return true
        }
    }

