//
//  Product.swift
//  OpenCloset
//
//  Created by Giorgia Granata on 12/11/24.
//

import Foundation

struct Product: Decodable, Identifiable, Hashable {
    var id = UUID().uuidString
    var userID: String
    var name: String
    var size: String
    var condition: String
    var itemDescription: String
    var imageURLs: [String]
    var isDonate: Bool
    var isSwap: Bool
    
    private enum CodingKeys: String, CodingKey {
        case userID
        case name
        case size
        case condition
        case itemDescription
        case imageURLs
        case isDonate
        case isSwap
    }
}

