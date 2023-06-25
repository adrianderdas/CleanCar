//
//  LoginViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 19/06/2023.
//

import UIKit
import FirebaseAuth
import JGProgressHUD


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let spinner = JGProgressHUD(style: .dark)

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
    
    // Przechodzenie do kolejnego pola przez "dalej"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordFireld.becomeFirstResponder()
        } else if textField == passwordFireld {
            textField.resignFirstResponder()
        }
        return true
    }
    
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
        
      //  navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Rejestracja", style: .done, target: self, action: #selector(didTapRegister))
        
        emailField.delegate = self
        passwordFireld.delegate = self
      
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordFireld)
        scrollView.addSubview(loginButton)
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
        
        guard let email = emailField.text, let password = passwordFireld.text, !email.isEmpty, !password.isEmpty else {
            //alertUserLoginError()
            return
        }
        
        spinner.show(in: view)

        // Firebase Log in
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email: \(email)")
                return
            }
            
            let user = result.user
            print("user: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            
            DispatchQueue.main.async {
                strongSelf.spinner.dismiss()
            }
 
             
        })
    }

}
