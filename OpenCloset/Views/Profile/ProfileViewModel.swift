//
//  ProfileViewModel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    
    @Published var productList: [Product] = []
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        let userID = Auth.auth().currentUser?.uid ?? ""
        let collection: Query = Firestore.firestore().collection("Products").whereField("userID", isEqualTo: userID)
        isLoading = true
        collection.getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                self?.showAlert(message: error.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    do {
                        var product = try document.data(as: Product.self)
                        product.id = document.documentID
                        self?.productList.append(product)
                    } catch(let error) {
                        self?.showAlert(message: "Error decoding profile: \(error)")
                    }
                }
                self?.isLoading = false
            }
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
        isLoading = false
    }
    
    func addProduct(product: Product) {
        productList.append(product)
    }
}

