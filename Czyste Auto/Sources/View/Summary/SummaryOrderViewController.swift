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
        let button = UIButton()
        button.setTitle("Podsumowanie", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let cityTextField: UILabel = {
        let label = UILabel()
        label.text = "Miejscowość"
        return label
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
    
    
    private let postalCodeTextField: UILabel = {
        let label = UILabel()
        label.text = "Kod pocztowy"
        return label
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
    
    
    private let houseNumberTextField: UILabel = {
        let label = UILabel()
        label.text = "Numer domu"
        return label
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
    
    private let phoneTextField: UILabel = {
        let label = UILabel()
        label.text = "Numer telefonu"
        return label
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
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Konieczne dla funkcji textFieldShouldReturn (zamkniecia klawiatury)
        phoneField.delegate = self
        view.backgroundColor = .systemBackground
        
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        
        title = "Adres odbioru"
        
        view.addSubview(scrollView)
        view.addSubview(orderButton)

        scrollView.addSubview(cityTextField)
        scrollView.addSubview(cityField)
        
        scrollView.addSubview(postalCodeTextField)
        scrollView.addSubview(postalCodeField)
        
        scrollView.addSubview(houseNumberTextField)
        scrollView.addSubview(houseNumberField)
        
        scrollView.addSubview(phoneTextField)
        scrollView.addSubview(phoneField)
        
        scrollView.isUserInteractionEnabled = true
        
    }
    @objc private func orderButtonTapped() {
        let vc = FinalSummaryViewController()
        
        //Przypisanie wartości z pól tekstowych
        vc.city = cityField.text ?? ""
        vc.postalCode = postalCodeField.text ?? ""
        vc.houseNumber = houseNumberField.text ?? ""
        vc.phone = phoneField.text ?? ""
                
        
        vc.hidesBottomBarWhenPushed = true
        vc.selectedServices = self.selectedServices  //Przekazanie danych
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
        
        let buttonHeight: CGFloat = 50
        let labelHeight: CGFloat = 20

        scrollView.frame = view.bounds

        
        cityTextField.frame = CGRect(x: 30, y: 20, width: scrollView.width-60, height: labelHeight)
        
        cityField.frame = CGRect(x: 30,
                                 y: cityTextField.bottom+5,
                                  width: scrollView.width-60,
                                 height: 52)
        
        
        postalCodeTextField.frame = CGRect(x: 30,
                                  y: cityField.bottom + 10,
                                  width: scrollView.width-60,
                                 height: labelHeight)
        
        postalCodeField.frame = CGRect(x: 30,
                                  y: postalCodeTextField.bottom + 5,
                                  width: scrollView.width-60,
                                 height: 52)
        
        houseNumberTextField.frame = CGRect(x: 30,
                                        y: postalCodeField.bottom + 10,
                                  width: scrollView.width-60,
                                 height: labelHeight)
        
        houseNumberField.frame = CGRect(x: 30,
                                        y: houseNumberTextField.bottom + 5,
                                  width: scrollView.width-60,
                                 height: 52)
        
        
        phoneTextField.frame = CGRect(x: 30,
                                  y: houseNumberField.bottom + 10,
                                  width: scrollView.width-60,
                                 height: labelHeight)
        
        phoneField.frame = CGRect(x: 30,
                                  y: phoneTextField.bottom + 5,
                                  width: scrollView.width-60,
                                 height: 52)
        
        orderButton.frame = CGRect(x: 10, y: view.height-buttonHeight-10, width: view.width-20, height: buttonHeight)

        
        self.cityField.text = FirebaseService.shared.firebaseCity
        self.postalCodeField.text = FirebaseService.shared.firebasePostalCode
        self.houseNumberField.text = FirebaseService.shared.firebaseHouseNumber
        self.phoneField.text = FirebaseService.shared.firebasePhone
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}





