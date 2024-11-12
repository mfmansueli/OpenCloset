//
//  Profile.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import Foundation

struct Profile: Identifiable, Decodable {
    var id: String = UUID().uuidString
    var name: String
    var surname: String
    var email: String
    var about: String
    var profileImageURL: String
}
