//
//  AddProductViewModel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import Foundation
import UIKit

class AddProductViewModel: ObservableObject {
    
    @Published var itemDescription: String = ""
    @Published var selectedSize: String = "P"
    @Published var selectedCondition: String = "Like New"
    @Published var isDonate: Bool = false
    @Published var isSwap: Bool = true
    
    @Published var showCamera: Bool = false
    @Published var showPhotoLibrary: Bool = false
    @Published var showPhotoOptions: Bool = false
    @Published var productImageList: [UIImage] = []
    @Published var productImage: UIImage?
    
}
