//
//  RegisterViewModel.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 23/09/2023.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit

class RegisterViewModel {
    
    var email: String?
    var password: String?
    
    var firstName: String?
    var lastName: String?
    var city: String?
    var postalCode: String?
    var houseNumber: String?
    var phone: String?
    var repeatPassword: String?
    
    
    func register(completion: @escaping (Bool, String?) -> Void) {
        
        guard let email = email, let password = password, let firstName = firstName, let lastName = lastName, let city = city, let postalCode = postalCode, let houseNumber = houseNumber, let phone = phone, !email.isEmpty, !password.isEmpty, phone.count == 9, password.count>6, password == repeatPassword  else {
            completion(false, "Niepoprawny email lub hasło")
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {
            authResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }
                     
            guard let userID = Auth.auth().currentUser?.uid else {
                print("User ID is not available")
                return
            }
            
            let db = Firestore.firestore()
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
                    completion(false, "Error adding user dataa: \(err)")
                } else {
                    print("User added with ID: \(userID)")
                    completion(true, nil)
                }
            }
        }
        
    }
    
    
    
    
    
    
    func setUserDefaults(email: String, firstName:String, lastName:String) {
        UserDefaults.standard.setValue(email, forKey: "email")
        UserDefaults.standard.setValue("\(firstName) and \(lastName)", forKey: "name")
    }
    
    
    
    func addUserInUsersCollection(userID: String, firstName: String, lastName: String, email: String, city: String, postalCode: String, houseNumber: String, phone: String) {
        
      
    }

}
