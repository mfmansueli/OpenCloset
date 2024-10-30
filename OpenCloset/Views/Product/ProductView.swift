//
//  ProductView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI

struct ProductView: View {
    var body: some View {
        VStack {
            // Header with back button and title
            HStack {
                Button(action: {
                    // Action for back button
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.orange)
                }
                Text("Paola's Closet")
                    .foregroundColor(.orange)
                    .font(.headline)
                Spacer()
            }
            .padding()
            
            // Image of the hat
            Image("handmade_hat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            // Hat title
            Text("Handmade Hat")
                .font(.title)
                .padding(.top)
            
            // Action buttons
            HStack {
                Button(action: {
                    // Action for swap button
                }) {
                    Text("Swap")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    // Action for donate button
                }) {
                    Text("Donate")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            // Details about the hat
            VStack(alignment: .leading) {
                Text("Condition: new")
                Text("Material: wool")
                Text("Brand: handmade")
                Text("Season: winter/fall")
                Text("Color: lilac, green, orange, yellow")
                Text("Size: one size, 80 cm")
                Text("Description: The hat is handmade by my aunt, I donate it because it’s not my style.")
            }
            .padding()
            
            Spacer()
            
            // Ask Info button
            Button(action: {
                // Action for ask info button
            }) {
                Text("Ask Info")
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    ProductView()
}
