//
//  AddProductViewModel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class AddProductViewModel: ObservableObject {
    
    @Published var itemDescription: String = ""
    @Published var name: String = ""
    @Published var size: String = ""
    @Published var selectedCondition: String = "Gently used"
    @Published var isDonate: Bool = false
    @Published var isSwap: Bool = true
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading = false
    
    @Published var showCamera: Bool = false
    @Published var showPhotoLibrary: Bool = false
    @Published var showPhotoOptions: Bool = false
    @Published var productImageList: [UIImage] = []
    
    @Published var itemNameError: String?
    @Published var itemDescriptionError: String?
    @Published var sizeError: String?
    var onAddProductCompletion: (() -> Void)?
    @Published var productImage: UIImage? {
        didSet {
            if let productImage = productImage {
                productImageList.append(productImage)
            }
        }
    }
    
    func getProductImage(with position: Int) -> UIImage? {
        if !productImageList.isEmpty, position < productImageList.count {
            return productImageList[position]
        }
        
        return nil
    }
    
    func removeImage() {
        productImageList.removeLast()
    }
    
    func addProduct() {
        guard validateInputs() else {
            return
        }
        let storage = Storage.storage()
        
        var imageURLs: [String] = []
        
        isLoading = true
        for (indoex, image) in productImageList.enumerated() {
            let storageRef = storage.reference().child("product_images/\(UUID().uuidString).jpg")
            if let imageData = image.jpegData(compressionQuality: 0.3) {
                storageRef.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
                    if let error = error {
                        self?.showAlert(message: "Error uploading image: \(error.localizedDescription)")
                        return
                    }
                    
                    storageRef.downloadURL { [weak self] (url, error) in
                        if let error = error {
                            self?.showAlert(message: "Error getting download URL: \(error.localizedDescription)")
                        } else if let url = url {
                            imageURLs.append(url.absoluteString)
                        }
                        
                        if imageURLs.count == self?.productImageList.count {
                            self?.saveProduct(with: imageURLs)
                        }
                    }
                }
            }
        }
    }
    
    func saveProduct(with imagesURLs: [String]) {
        let collection = Firestore.firestore().collection("Products")
        let documentData: [String: Any] = [
            "userID": Auth.auth().currentUser?.uid ?? "",
            "itemDescription": self.itemDescription,
            "size": self.size,
            "name": self.name,
            "condition": self.selectedCondition,
            "isDonate": self.isDonate,
            "isSwap": self.isSwap,
            "imageURLs": imagesURLs
        ]
        
        collection.addDocument(data: documentData) { [weak self] error in
            self?.isLoading = false
            if let error = error {
                self?.showAlert(message: "Error adding document: \(error.localizedDescription)")
            } else {
                self?.onAddProductCompletion?()
            }
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
        isLoading = false
    }
    
    private func validateInputs() -> Bool {
        var isValid = true
        if productImageList.isEmpty {
            showAlert(message: "Add some images to your product.")
            isValid = false
        }
        
        if name.isEmpty {
            itemNameError = "Item name cannot be empty."
            isValid = false
        } else {
            itemNameError = nil
        }
        
        if itemDescription.isEmpty {
            itemDescriptionError = "Item description cannot be empty."
            isValid = false
        } else {
            itemDescriptionError = nil
        }
        
        if size.isEmpty {
            sizeError = "Size cannot be empty."
            isValid = false
        } else {
            sizeError = nil
        }
        
        return isValid
    }
}
