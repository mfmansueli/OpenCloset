//
//  ChatHeaderViewModel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 17/11/24.
//
import Foundation
import FirebaseFirestore

class ChatHeaderViewModel: ObservableObject {
    @Published var product: Product?
    
    func loadProduct(productID: String) {
        let ref = Firestore.firestore().collection("Products").document(productID)
        
        ref.getDocument { [weak self] (document, error) in
            if let error = error {
                self?.showAlert(message: error.localizedDescription)
            } else if let document = document, document.exists {
                do {
                    let product = try document.data(as: Product.self)
                    self?.product = product
                } catch(let error) {
                    self?.showAlert(message: "Error decoding product: \(error)")
                }
            } else {
                self?.showAlert(message: "Product not found")
            }
        }
    }

    // Example showAlert function
    func showAlert(message: String) {
        // Implement your alert mechanism here
        print("Alert: \(message)")
    }
}
