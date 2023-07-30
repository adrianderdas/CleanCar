//
//  CheckPhoneNumberViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 27/07/2023.
//

import UIKit

class CheckPhoneNumberViewController: UIViewController {
    
    private let phoneField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Numer telefonu"
        
        field.keyboardType = .numberPad
        
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(phoneField)
        
        phoneField.frame = CGRect(x: 10, y: 40, width: view.width-20, height: 20)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
