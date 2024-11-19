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

struct Profile: Identifiable, Decodable, Encodable {
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
        case id
        case name
        case surname
        case email
        case about
        case profileImageURL
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(String.self, forKey: .id)) ?? UUID().uuidString
        name = try container.decode(String.self, forKey: .name)
        surname = try container.decode(String.self, forKey: .surname)
        email = try container.decode(String.self, forKey: .email)
        about = try container.decode(String.self, forKey: .about)
        profileImageURL = try container.decode(String.self, forKey: .profileImageURL)
    }
}
