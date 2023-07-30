//
//  SignupModelValidatorProtocol.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 30/07/2023.
//

import Foundation

protocol SignupModelValidatorProtocol {
    
      func isValidEmailFormat(email: String) -> Bool
      func isPasswordValid(password: String) -> Bool
      
      func doPasswordsMatch(password: String, repeatPassword: String) -> Bool
}

