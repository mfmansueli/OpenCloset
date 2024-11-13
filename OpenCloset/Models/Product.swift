//
//  Product.swift
//  OpenCloset
//
//  Created by Giorgia Granata on 12/11/24.
//

import Foundation

struct Product: Identifiable, Hashable, Decodable {
    var id = UUID().uuidString
    var name: String
    var size: String
    var condition: String
    var description: String
    var image: [String]
    var isDonation: Bool
    var isSwapping: Bool
}

