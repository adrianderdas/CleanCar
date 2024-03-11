//
//  Service.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 25/06/2023.
//

import Foundation

struct DownloadedService: Decodable, Encodable, Hashable {
    let id: Int
    let title: String
    let price: Float
    let description: String?
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "SER_ID"
        case title = "SER_Title"
        case price = "SER_Price"
        case description = "SER_Description"
        case imageURL = "SER_Image"
    }
    
 
}

extension DownloadedService: Displayable {
    var serviceImageURL: URL {
        imageURL
    }
    
    var serviceTitleLabelText: String {
        title
    }
    
    var servicePriceText: Float {
        price
    }
        
    var serviceDescriptionText: String {
        description ?? "brak opisu"
    }
    
    
}

protocol Displayable {
    var serviceTitleLabelText: String {get}
    var servicePriceText: Float {get}
    var serviceDescriptionText: String {get}
    var serviceImageURL: URL {get}
}


struct ServicesResponse: Decodable {
    let count: Int
    let all: [DownloadedService]
    
    enum CodingKeys: String, CodingKey {
        case count
        case all = "services"
    }
}
