//
//  Untitled.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import Foundation
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    
    @Published var items: [Profile] = []
    @Published var errorMessage: String?
    @Published var page = 1
    
    init() {
        fetchProfiles(page: page)
    }
    
    func fetchProfiles(page: Int) {
        let collection: Query = Firestore.firestore().collection("Profiles").limit(toLast: page * 50).order(by: "name")
        
        collection.getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                self?.errorMessage = error.localizedDescription
            } else {
                for document in snapshot!.documents {
                    do {
                        // Try to decode the document data into the Profile object
                        if var profile = try? document.data(as: Profile.self) {
                            profile.id = document.documentID
                            self?.items.append(profile)
                        }
                    } catch(let error) {
                        print("Error decoding profile: \(error)")
                    }
                }
                
            }
        }
    }
}
