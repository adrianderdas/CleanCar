//
//  RegisterViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 19/06/2023.
//

import UIKit


class RegisterViewController: UIViewController {
    
    private let viewModel = RegisterViewModel()
    

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let firstNameField: UITextField = {
        let field = UITextField()
        
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Imię"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Nazwisko"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
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
    
    private let passwordField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Hasło"
        
        field.keyboardType = .default
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        field.isSecureTextEntry = true
        return field
    }()
    
    private let repeatPasswordField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Powtórz Hasło"
        
        field.keyboardType = .default
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        field.isSecureTextEntry = true
        return field
    }()
    
    private let cityField: UITextField = {
        let field = UITextField()
        
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Miejscowość"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let postalCodeField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Kod pocztowy"
        field.keyboardType = .numbersAndPunctuation
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let houseNumberField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Numer domu"
        field.keyboardType = .numbersAndPunctuation
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let phoneField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Numer telefonu"
        field.keyboardType = .numbersAndPunctuation
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Rejestracja", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Wpisz potrzebne informacje", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Popraw", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func registerButtonTapped() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        repeatPasswordField.resignFirstResponder()
        cityField.resignFirstResponder()
        postalCodeField.resignFirstResponder()
        houseNumberField.resignFirstResponder()
        phoneField.resignFirstResponder()
        
        viewModel.firstName = firstNameField.text
        viewModel.lastName = lastNameField.text
        viewModel.email = emailField.text
        viewModel.password = passwordField.text
        viewModel.repeatPassword = repeatPasswordField.text
        viewModel.city = cityField.text
        viewModel.postalCode = postalCodeField.text
        viewModel.houseNumber = houseNumberField.text
        viewModel.phone = phoneField.text
              
      
        viewModel.register { [weak self] success, errorMessage in
            
           
            if success {
                self?.navigationController?.dismiss(animated: true, completion: nil)
            }
            else {
                // Show alert with error info
                let alert = UIAlertController(title: "Woops", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Popraw", style: .cancel))
                self?.present(alert, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .systemBackground
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        repeatPasswordField.delegate = self

        cityField.delegate = self
        postalCodeField.delegate = self
        houseNumberField.delegate = self
        phoneField.delegate = self
        
        // Add subviews
        view.addSubview(scrollView)
        
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(repeatPasswordField)

        scrollView.addSubview(cityField)
        scrollView.addSubview(postalCodeField)
        scrollView.addSubview(houseNumberField)
        scrollView.addSubview(phoneField)
        
        scrollView.addSubview(registerButton)
        
        scrollView.isUserInteractionEnabled = true
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        firstNameField.frame = CGRect(x: 30,
                                      y: 20,
                                      width: scrollView.width-60,
                                      height: 52)
        lastNameField.frame = CGRect(x: 30,
                                     y: firstNameField.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)
        repeatPasswordField.frame = CGRect(x: 30,
                                     y: passwordField.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)
        cityField.frame = CGRect(x: 30,
                                 y: repeatPasswordField.bottom + 10,
                                 width: scrollView.width-60,
                                 height: 52)
        postalCodeField.frame = CGRect(x: 30,
                                       y: cityField.bottom + 10,
                                       width: scrollView.width-60,
                                       height: 52)
        houseNumberField.frame = CGRect(x: 30,
                                        y: postalCodeField.bottom + 10,
                                        width: scrollView.width-60,
                                        height: 52)
        phoneField.frame = CGRect(x: 30,
                                  y: houseNumberField.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)
        
        registerButton.frame = CGRect(x: 30,
                                      y: phoneField.bottom + 10,
                                      width: scrollView.width-60,
                                      height: 52)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case firstNameField:
            lastNameField.becomeFirstResponder()
        case lastNameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            repeatPasswordField.becomeFirstResponder()
        case repeatPasswordField:
            cityField.becomeFirstResponder()
        case cityField:
            postalCodeField.becomeFirstResponder()
        case postalCodeField:
            houseNumberField.becomeFirstResponder()
        case houseNumberField:
            phoneField.becomeFirstResponder()
        case phoneField:
            textField.resignFirstResponder()
            
        default:
            firstNameField.becomeFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let point = textField.convert(textField.bounds.origin, to: self.scrollView)
        let scrollPoint = CGPoint(x: 0, y:  point.y - textField.frame.size.height*2)
        self.scrollView.setContentOffset(scrollPoint, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let topOffset = CGPoint(x: 0, y: -navBarHeight*2)
        scrollView.setContentOffset(topOffset, animated: true)
    }
    
}

extension RegisterViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
