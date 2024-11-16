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
    @Published var size: String = ""
    @Published var selectedCondition: String = "Gently used"
    @Published var isDonate: Bool = false
    @Published var isSwap: Bool = true
    
    @Published var showCamera: Bool = false
    @Published var showPhotoLibrary: Bool = false
    @Published var showPhotoOptions: Bool = false
    @Published var productImageList: [UIImage] = []
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
        let storage = Storage.storage()
        
        var imageURLs: [String] = []
        // Upload images to Firebase Storage
        for (index, image) in productImageList.enumerated() {
            let storageRef = storage.reference().child("product_images/\(UUID().uuidString).jpg")
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                    if let error = error {
                        print("Error uploading image: \(error)")
                        return
                    }
                    
                    storageRef.downloadURL { [weak self] (url, error) in
                        if let error = error {
                            print("Error getting download URL: \(error)")
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
                "itemDescription": self.itemDescription,
                "size": self.size,
                "selectedCondition": self.selectedCondition,
                "isDonate": self.isDonate,
                "isSwap": self.isSwap,
                "imageUrls": imagesURLs
            ]
            
            collection.addDocument(data: documentData) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully!")
                }
            }
    }
}
