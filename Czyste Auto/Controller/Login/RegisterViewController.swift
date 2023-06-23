//
//  RegisterViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 19/06/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let firstNameField: UITextField = {
       let field = UITextField()
        
        field.autocapitalizationType = .none
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
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
      private let passwordField: UITextField = {
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
    
    private let cityField: UITextField = {
       let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
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
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let phoneField: UITextField = {
       let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Numer telefonu"
        
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
        cityField.resignFirstResponder()
        postalCodeField.resignFirstResponder()
        houseNumberField.resignFirstResponder()
        phoneField.resignFirstResponder()
        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              let city = cityField.text,
              let postalCode = postalCodeField.text,
              let houseNumber = houseNumberField.text,
              let phone = phoneField.text,

              !email.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !city.isEmpty,
              !postalCode.isEmpty,
              !houseNumber.isEmpty,
              !phone.isEmpty,
              phone.count == 9,
              password.count>6,
              !lastName.isEmpty else {
            alertUserLoginError()
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
            guard authResult != nil, error == nil else {
                print("Error creating user")
                return
            }
            
            UserDefaults.standard.setValue(email, forKey: "email")
            UserDefaults.standard.setValue("\(firstName) and \(lastName)", forKey: "name")
            
            let db = Firestore.firestore()
            
            guard let userID = Auth.auth().currentUser?.uid else {
                print("User ID is not available")
                return
            }
            
            //var ref: DocumentReference? = nil
            db.collection("users").document(userID).setData([
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "city": city,
                "postalCode": postalCode,
                "houseNumber": houseNumber,
                "phone": phone
                
            ]) { err in
                if let err = err {
                    print("Error adding user data: \(err)")
                } else {
                    print("User added with ID: \(userID)")
                }
            }

            self.navigationController?.dismiss(animated: true, completion: nil)
        })
        
        
            
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        // Add subviews
        view.addSubview(scrollView)
        
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
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
        cityField.frame = CGRect(x: 30,
                                  y: passwordField.bottom + 10,
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
