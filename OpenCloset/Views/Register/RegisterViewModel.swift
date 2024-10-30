//
//  RegisterViewModel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import Foundation
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    
    @Published var profileImage: UIImage?
    
    func register() {
        let collection = Firestore.firestore().collection("Profiles")
            
            let profileData: [String: Any] = [
                "name": "Test",
                "email": "mateusferneda@gmail.com",
                "password": "123456"
            ]
            
            collection.addDocument(data: profileData) { error in
                if let error = error {
                    print("Error adding document: \(error.localizedDescription)")
                } else {
                    print("Document added successfully!")
                }
            }
    }
}
