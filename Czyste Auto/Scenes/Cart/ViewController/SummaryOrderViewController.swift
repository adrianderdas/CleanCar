//
//  SummaryOrderViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 19/06/2023.
//

import UIKit



class SummaryOrderViewController: UIViewController {
    
    public var selectedServices: [DownloadedService] = []
    
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
        
        setView()
        setContraints()
        setTextFields()
    }
    
    func setView() {
        view.backgroundColor = .systemBackground
        title = "Adres odbioru"
        
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    }
    
    func setTextFields() {
        cityField.delegate = self
        postalCodeField.delegate = self
        houseNumberField.delegate = self
        phoneField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        self.cityField.text = FirebaseService.shared.firebaseCity
        self.postalCodeField.text = FirebaseService.shared.firebasePostalCode
        self.houseNumberField.text = FirebaseService.shared.firebaseHouseNumber
        self.phoneField.text = FirebaseService.shared.firebasePhone
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
        
        let lowSpacing: CGFloat = 5
        let spacing: CGFloat = 20
        let fieldHeight: CGFloat = 40

        NSLayoutConstraint.activate([
            // City
            cityTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            cityTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: spacing),
            
            cityField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: lowSpacing),
            cityField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            cityField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            cityField.heightAnchor.constraint(equalToConstant: fieldHeight),
            
            // Postal code
            postalCodeTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            postalCodeTextField.topAnchor.constraint(equalTo: cityField.bottomAnchor, constant: spacing),
            
            postalCodeField.topAnchor.constraint(equalTo: postalCodeTextField.bottomAnchor, constant: lowSpacing),
            postalCodeField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            postalCodeField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            postalCodeField.heightAnchor.constraint(equalToConstant: fieldHeight),
            
            // House number
            houseNumberTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            houseNumberTextField.topAnchor.constraint(equalTo: postalCodeField.bottomAnchor, constant: spacing),
            
            houseNumberField.topAnchor.constraint(equalTo: houseNumberTextField.bottomAnchor, constant: lowSpacing),
            houseNumberField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            houseNumberField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            houseNumberField.heightAnchor.constraint(equalToConstant: fieldHeight),
            
            // Phone
            phoneTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            phoneTextField.topAnchor.constraint(equalTo: houseNumberField.bottomAnchor, constant: spacing),
            
            phoneField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: lowSpacing),
            phoneField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            phoneField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            phoneField.heightAnchor.constraint(equalToConstant: fieldHeight),
            
            // Order Button
            orderButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            orderButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            orderButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            orderButton.heightAnchor.constraint(equalToConstant: 50)
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

    
}

extension SummaryOrderViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case cityField:
            postalCodeField.becomeFirstResponder()
        case postalCodeField:
            houseNumberField.becomeFirstResponder()
        case houseNumberField:
            phoneField.becomeFirstResponder()
        case phoneField:
            textField.resignFirstResponder()
            
        default:
            cityField.becomeFirstResponder()
        }
        
        return true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
        
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
