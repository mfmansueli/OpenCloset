//
//  Profile.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

/**
 :  Significa declarar o tipo
  = Significa receber um valor equivalente
 Tudo que eh roxo sao tipos.

 **/
import Foundation

struct Profile: Identifiable, Decodable {
    var id: String = UUID().uuidString
    var name: String
    var surname: String
    var email: String
    var about: String
    var profileImageURL: String
    var distance: String = ""
    
    init(id: String = UUID().uuidString, name: String, surname: String, email: String, about: String, profileImageURL: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.about = about
        self.profileImageURL = profileImageURL
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case surname
        case email
        case about
        case profileImageURL
    }
}
