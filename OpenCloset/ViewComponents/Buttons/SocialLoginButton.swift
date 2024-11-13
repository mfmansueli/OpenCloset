//
//  SocialLoginButton.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 10/11/24.
//

import SwiftUI

struct SocialLoginButton: View {
    var imageName: String
    var buttonText: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.black)
                    .frame(width: 20, height: 20)
                Spacer()
                Text(buttonText)
                    .foregroundStyle(.black)
                    .font(.headline)
                    .padding(.leading, -20)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 26)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    SocialLoginButton(imageName: "applelogo", buttonText: "Sign in with Apple", action: { })
}
