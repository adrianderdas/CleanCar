//
//  FinalSummaryViewModel.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 08/10/2023.
//


import FirebaseFirestore

class FinalSummaryViewModel {
    
    weak var delegate: FinalSummaryViewModelDelegate?
    
    var userID = FirebaseService.shared.getuserId()
    
    func uploadOrderToFirebase(selectedServices: [DownloadedService], city: String, postalCode: String, houseNumber: String, phone: String, totalPrice: Int) {
        
        let servicesData = mapServicesFromCollectionToDictionaryType(selectedServices: selectedServices)
      
        let adressData: [String: Any] = [
            "city": city,
            "postalCode": postalCode,
            "houseNumber": houseNumber,
            "phoneNumber": phone
        ]
        
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("orders").addDocument(data: [
            "user": userID,
            "orders": servicesData,
            "totalPrice": totalPrice,
            "adress": adressData,
            "is_realized": false
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                self.delegate?.didFailInUploadOrder(err)
                return
            } else {
                self.delegate?.didUploadOrderSuccess()
                guard let orderID = ref?.documentID, let userID = self.userID else {
                    return
                }
                
                self.uploadCollectionOrdersToUsersGroupInFirebase(userID: userID, orderID: orderID)
                
                self.clearCart()
            }
        }
    }
    
    func mapServicesFromCollectionToDictionaryType(selectedServices: [DownloadedService]) -> [[String: Any]] {
        let servicesData = selectedServices.map {
            ["name": $0.serviceTitleLabelText, "price": $0.servicePriceText] as [String : Any]
        }
        return servicesData
    }

    func clearCart() {
        CleanCarViewModel().selectedServices = []
    }
    
    func uploadCollectionOrdersToUsersGroupInFirebase(userID: String, orderID: String) {
        Firestore.firestore().collection("users").document(userID).updateData([
            "orders": FieldValue.arrayUnion([orderID])
        ])
    }
    
}

protocol FinalSummaryViewModelDelegate: AnyObject {
    func didUploadOrderSuccess()
    func didFailInUploadOrder(_ error: Error)
}


