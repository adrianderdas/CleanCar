//
//  ZeroViewModel.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 07/02/2024.
//

import Foundation
import FirebaseAuth

class ZeroViewModel {
    func isUserLogIn() -> Bool {
        return FirebaseAuth.Auth.auth().currentUser != nil
    }
}
