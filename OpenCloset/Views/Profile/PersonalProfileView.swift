//
//  PersonalProfileView.swift
//  OpenCloset
//
//  Created by Iago Xavier de Lima on 07/11/24.
//

import SwiftUI


struct PersonalProfileView: View {
    var profile: Profile = Profile(name: "", surname: "", email: "", about: "", profileImageURL: "")
    var imageURL: String = ""
    var body: some View {
        NavigationStack {
            
            
            VStack {
                HStack {
                    
                    Circle()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.blue)
                    
                    Text("\(profile.name) \(profile.surname)")
                    .font(.headline)            }
                Spacer()
                
                NavigationLink("Add Product", destination: AddProductView())
                    
               
                NavigationLink(destination: AddProductView()) {
                        Button("Add Clothes") {
                            
                        }.buttonStyle(PrimaryButtonStyle())
                    
                }
            }
        }
    }
}


#Preview {
    PersonalProfileView(profile: Profile(name: "Paola", surname: "Campanile", email: "paula@campanile.com", about: "Second-hand enthusiast 🌱 ", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png"))
}
