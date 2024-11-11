//
//  ProfileView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel = ProfileViewModel()
    var profile: Profile
    
    var body: some View {
        VStack {
            HStack {
                
                KFImage(URL(string: profile.profileImageURL)) .resizable()
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .overlay(Circle()
                    .stroke(Color .white, lineWidth: 2))
                    .shadow(radius: 10)
                    .padding(.leading, 20)
                
                VStack(alignment: .leading) {
                    Text("Paola Campanile")
                        .padding(.bottom,30)
                        .padding(.leading, 15)
                        .font(.title2)
                    

                    HStack {
                        Text("150 m")
                            .padding(5)
                            .background(Color.pink)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 2) {
                            ForEach(0..<3) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
            
     
            
            
            Spacer()
            
            Button(action: {
                // Action for Ask Info
            }) {
                Text("Ask Info ♡")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
    }
}

#Preview {
    ProfileView(profile: Profile(name: "Paola", surname: "Campanile", email: "paula@campanile.com", about: "Second-hand enthusiast 🌱 ", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png"))
}
