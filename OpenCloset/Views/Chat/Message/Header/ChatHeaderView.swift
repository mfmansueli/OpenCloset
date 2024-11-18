//
//  ChatHeaderView.swift
//  OpenCloset
//
//  Created by Giorgio Durante on 12/11/24.
//

import SwiftUI
import Kingfisher

struct ChatHeaderView: View {
    @ObservedObject var viewModel: ChatHeaderViewModel
    var productId: String = ""
    
    init(productId: String = "") {
        self.viewModel = ChatHeaderViewModel(productId: productId)
    }
    
    var body: some View {
        if let product = viewModel.product {
            NavigationLink {
                ProductView(product: product)
            } label: {
                VStack {
                    Divider()
                        .frame(height: 1)
                        .background(Color("LinePink"))
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 80, height: 80)
                            
                            KFImage(URL(string: viewModel.product?.imageURLs.first ?? ""))
                                .resizable()
                                .placeholder({
                                    Image(systemName: "hanger")
                                })
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                        }
                        
                        VStack(alignment: .leading) {
                            Text(product.name)
                                .font(.title2)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                            
                            Text(product.itemDescription)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.leading)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all)
                    
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color("LinePink"))
                }
            }
        }
             ProgressView("Loading product ...")
                .padding()
                .background(Color.white)
                .cornerRadius(10)
    }
}

#Preview {
    ChatHeaderView()
}
