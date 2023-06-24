//
//  FirebaseService.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 23/06/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

// Class used to set data showing in Settings and in Summary VC,


class FirebaseService {
    static let shared = FirebaseService()
    let db = Firestore.firestore()
    
    
    public var firebaseCity: String?
    public var firebaseEmail: String?
    public var firebaseFirstName: String?
    public var firebaseHouseNumber: String?
    public var firebaseLastName: String?
    public var firebasePhone: String?
    public var firebasePostalCode: String?
    
    
    
    func getuserId() -> String? {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Failed to fetch userID from FirebaseAuth")
            return nil
        }
        return userID
    }
    
    
    func getData() {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Failed to fetch userID from FirebaseAuth")
            return
        }
        
        let docRef = db.collection("users").document(userID)
        
        docRef.getDocument { (document, error) in
            if let error = error {
                print("Error getting document: \(error)")
            } else if let document = document, document.exists {
                if let data = document.data() {
                    self.firebaseCity = data["city"] as? String
                    self.firebaseEmail = data["email"] as? String
                    self.firebaseFirstName = data["firstName"] as? String
                    self.firebaseHouseNumber = data["houseNumber"] as? String
                    self.firebaseLastName = data["lastName"] as? String
                    self.firebasePhone = data["phone"] as? String
                    self.firebasePostalCode = data["postalCode"] as? String
                    
                    
                
            }
            else {
                print("Document data is nil or firstName is not a string.")
            }
        } else {
            print("Document does not exist.")
        }
    }
        
      
}
}

