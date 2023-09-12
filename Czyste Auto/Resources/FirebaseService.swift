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
    
    struct ServiceData {
        var name: String
        var price: Double
    }
    
    struct OrderData {
        var isRealized: Bool
        var totalPrice: Double
        var orders: [ServiceData]
    }
    
    public var firebaseOrders: [OrderData] = []

    static let shared = FirebaseService()
    let db = Firestore.firestore()
    
    
    public var firebaseCity: String?
    public var firebaseEmail: String?
    public var firebaseFirstName: String?
    public var firebaseHouseNumber: String?
    public var firebaseLastName: String?
    public var firebasePhone: String?
    public var firebasePostalCode: String?
    
    public var firebaseOrdersIds: Any? = []
    
    func getuserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func getUserOrders(completion: @escaping () -> Void) {
                
        guard let userID = getuserId() else {
            return
        }

        let docRef = db.collection("users").document(userID)

        docRef.getDocument { [self] (document, error) in
            if let error = error {
                print("Error getting document: \(error)")
            } else if let document = document, document.exists {
                if let data = document.data() {

                    self.firebaseOrdersIds = data["orders"]

                    if let orders = self.firebaseOrdersIds as? [String] {
                        let dispatchGroup = DispatchGroup()

                        self.firebaseOrders = []

                        for orderId in orders {
                            dispatchGroup.enter()
                            let orderDocRef = db.collection("orders").document(orderId)
                            orderDocRef.getDocument { (orderDocument, error) in
                                if let error = error {
                                    print("Error getting order document: \(error)")
                                } else if let orderDocument = orderDocument, orderDocument.exists {
                                    if let orderData = orderDocument.data() {

                                        // Get specific fields
                                        if let isRealized = orderData["is_realized"] as? Bool,
                                           let totalPrice = orderData["totalPrice"] as? Double,
                                           let servicesData = orderData["orders"] as? [[String: Any]] {
                                            // Now you have access to isRealized, totalPrice and orders.
                                            var services = [ServiceData]()
                                            for serviceData in servicesData {
                                                if let name = serviceData["name"] as? String,
                                                   let price = serviceData["price"] as? Double {
                                                    services.append(ServiceData(name: name, price: price))
                                                }
                                            }
                                            let order = OrderData(isRealized: isRealized, totalPrice: totalPrice, orders: services)
                                            self.firebaseOrders.append(order)
                                        } else {
                                            print("Order document data is nil.")
                                        }

                                        print("Firebase orders are:::: \(self.firebaseOrders)")
                                    } else {
                                        print("Order document does not exist.")
                                    }
                                }
                                dispatchGroup.leave()
                            }
                        }

                        dispatchGroup.notify(queue: .main) {
                            completion()
                        }
                    } else {
                        print("firebaseOrders cannot be cast to [String]")
                    }
                }
                else {
                    print("Document data is nil or firstName is not a string.")
                }
            } else {
                print("Document does not exist.")
            }
        }
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

