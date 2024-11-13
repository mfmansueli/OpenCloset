//
//  ProductView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI

struct ProductView: View {
    @State var condition = "Like New"
    
    var body: some View {
        VStack {
            // Image of the hat
            Image("handmade_hat")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 380)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            
            // Hat title
            VStack(alignment: .leading) {
                Text("Handmade Hat")
                    .font(.title)
                    .fontWeight(.semibold)
                
                // Action buttons
                HStack {
                    Text("Swap")
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(.accent)
                    .cornerRadius(8)
                        
                    Text("Donate")
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(.accent)
                    .cornerRadius(8)
                }
                .padding(.bottom, 5)
                
                // Details about the hat
                Text("Condition: Like New")
                Text("Size: S")
            
                VStack(alignment: .leading) {
                    Text("Item description")
                        .font(.headline)
                        .padding(.top, 1)
                    Text("A brief description of the item uploaded by the user goes here. Do we like without the grey background? Is it better?")
                    
                    // RoundedRectangle(cornerRadius: 10)
                    //   .foregroundStyle(Color.gray.opacity(0.2))
                    
                }
                // Ask Info button
                Button {
                    // action goes here
                } label: {
                    Text("Ask Info ♡")
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .padding(.all, 10)
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 10)
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

#Preview {
    ProductView()
}
