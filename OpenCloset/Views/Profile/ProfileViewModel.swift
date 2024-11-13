//
//  ProfileViewModel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import Foundation
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    
    @Published var productList: [Product] = [
        Product(name: "Handmade hat", size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                true, isSwapping: false),
        Product(name: "Handmade hat", size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                    true, isSwapping: false),
        Product(name: "Handmade hat", size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                true, isSwapping: false),
        Product(name: "Handmade hat", size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                true, isSwapping: false),
        Product(name: "Handmade hat", size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                true, isSwapping: false),
        Product(name: "Handmade hat", size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                true, isSwapping: false),
        Product(name: "Handmade hat", size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                true, isSwapping: false)
    ]
    var errorMessage: String = ""
    
    func fetchProducts() {
        let collection: Query = Firestore.firestore().collection("Products").order(by: "name").whereField("id", isEqualTo: "")
        collection.getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                self?.errorMessage = error.localizedDescription
            } else {
                for document in snapshot!.documents {
                    do {
                        var product = try document.data(as: Product.self)
                        product.id = document.documentID
                        self?.productList.append(product)
                    } catch(let error) {
                        print("Error decoding profile: \(error)")
                    }
                }
            }
        }
    }
    
}

