//
//  ChatHeaderViewModel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 17/11/24.
//
import Foundation

class ChatHeaderViewModel: ObservableObject {
    var productId: String
    @Published var product: Product?
    
    init(productId: String) {
        self.productId = productId
    }
    
    
}
