//
//  SummaryOrderViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 19/06/2023.
//

import UIKit



class SummaryOrderViewController: UIViewController, UITextFieldDelegate {
    
    public var selectedServices: [Service] = []
    
    private let orderButton: UIButton = {
        return FactoriesCartViewController.makeButton(withText: "Potwierdzam adres odbioru")

    }()
    
    private let cityTextField: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Miejscowość"
        return label
    }()

    private let cityField: UITextField = {
       let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    private let postalCodeTextField: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Kod pocztowy"
        return label
    }()

    private let postalCodeField: UITextField = {
       let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false

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
    
    
    private let houseNumberTextField: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Numer domu"
        return label
    }()
    
    private let houseNumberField: UITextField = {
       let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false

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
    
    private let phoneTextField: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Numer telefonu"
        return label
    }()
    
    private let phoneField: UITextField = {
       let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false

        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Numer telefonu"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneField.delegate = self
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        
        title = "Adres odbioru"
        
        setContraints()
        
    }
    
    func setContraints() {
        view.addSubview(cityTextField)
        view.addSubview(cityField)
        view.addSubview(postalCodeTextField)
        view.addSubview(postalCodeField)
        view.addSubview(houseNumberTextField)
        view.addSubview(houseNumberField)
        view.addSubview(phoneTextField)
        view.addSubview(phoneField)
        view.addSubview(orderButton)

        NSLayoutConstraint.activate([
            // City
            cityTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            cityTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            
            cityField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 5),
            cityField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            cityField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            cityField.heightAnchor.constraint(equalToConstant: 40),
            
            // Postal code
            postalCodeTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            postalCodeTextField.topAnchor.constraint(equalTo: cityField.bottomAnchor, constant: 40),
            
            postalCodeField.topAnchor.constraint(equalTo: postalCodeTextField.bottomAnchor, constant: 5),
            postalCodeField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            postalCodeField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            postalCodeField.heightAnchor.constraint(equalToConstant: 40),
            
            // House number
            houseNumberTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            houseNumberTextField.topAnchor.constraint(equalTo: postalCodeField.bottomAnchor, constant: 40),
            
            houseNumberField.topAnchor.constraint(equalTo: houseNumberTextField.bottomAnchor, constant: 5),
            houseNumberField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            houseNumberField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            houseNumberField.heightAnchor.constraint(equalToConstant: 40),
            
            // Phone
            phoneTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            phoneTextField.topAnchor.constraint(equalTo: houseNumberField.bottomAnchor, constant: 40),
            
            phoneField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 5),
            phoneField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            phoneField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            phoneField.heightAnchor.constraint(equalToConstant: 40),
            
            // Order Button
            orderButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            orderButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            orderButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            orderButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            
        ])
    }
    
    @objc private func orderButtonTapped() {
        let vc = FinalSummaryViewController()
        passDataToFinalSummaryVC(vc: vc)
        openFinalSummaryVC(vc: vc)
   }
    
    func passDataToFinalSummaryVC(vc: FinalSummaryViewController) {
        vc.city = cityField.text ?? ""
        vc.postalCode = postalCodeField.text ?? ""
        vc.houseNumber = houseNumberField.text ?? ""
        vc.phone = phoneField.text ?? ""
        vc.selectedServices = self.selectedServices
    }
    
    func openFinalSummaryVC(vc: FinalSummaryViewController) {
        vc.hidesBottomBarWhenPushed = true
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// Function used for hidden keyboards when user clicked "gotowe"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        self.cityField.text = FirebaseService.shared.firebaseCity
        self.postalCodeField.text = FirebaseService.shared.firebasePostalCode
        self.houseNumberField.text = FirebaseService.shared.firebaseHouseNumber
        self.phoneField.text = FirebaseService.shared.firebasePhone
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}


extension SummaryOrderViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
        
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


