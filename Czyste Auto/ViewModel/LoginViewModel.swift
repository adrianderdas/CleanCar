//
//  LoginViewModel.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 20/09/2023.
//

import FirebaseAuth


class LoginViewModel {
    
    var email: String?
    var password: String?
    
    func login(completionn: @escaping (Bool, String?) -> Void) {
        
        guard let email = email, let password = password, !email.isEmpty else {
            completionn(false, "Niepoprawny email lub hasło")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completionn(false, error.localizedDescription)
            }
            
            if let _ = authResult {
                completionn(true, nil)
            } else {
                completionn(false, "Nieznany błąd")
            }

        }
        
    }
    
}
