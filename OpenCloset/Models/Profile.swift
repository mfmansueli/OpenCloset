//
//  Profile.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

//

/**
 :  Significa declarar o tipo
  = Significa receber um valor equivalente
 Tudo que eh roxo sao tipos.

 **/
import Foundation

struct Profile: Identifiable, Decodable {
    var id = UUID().uuidString
    var name: String
    var surname: String
    var email: String
    var about: String
    var profileImageURL: String
    
}
