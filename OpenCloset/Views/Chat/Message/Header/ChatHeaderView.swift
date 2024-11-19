//
//  ChatHeaderView.swift
//  OpenCloset
//
//  Created by Giorgio Durante on 12/11/24.
//

import SwiftUI
import Kingfisher

struct ChatHeaderView: View {
    @StateObject var viewModel: ChatHeaderViewModel = ChatHeaderViewModel()
    var productId: String = ""
    
    init(productId: String = "") {
        self.productId = productId
    }
    
    var body: some View {
        VStack {
            if let product = viewModel.product {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 80, height: 80)
                        
                        KFImage(URL(string: viewModel.product?.imageURLs.first ?? ""))
                            .resizable()
                            .fade(duration: 0.25)
                            .placeholder{
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color.accent))
                            }
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.title2)
                            .lineLimit(2)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        
                        Text(product.itemDescription)
                            .font(.subheadline)
                            .lineLimit(2)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Button("Confirm\nSwap") {
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color.lightAccent)
                    .cornerRadius(26)
                    .padding(.horizontal, 16)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.all)
                
                
                Divider()
                    .frame(height: 1)
                    .background(Color("LinePink"))
            } else {
                ProgressView("Loading product ...")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }.onAppear {
            viewModel.loadProduct(productID: productId)
        }
    }
}

#Preview {
    ChatHeaderView()
}
