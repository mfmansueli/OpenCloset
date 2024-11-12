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
    @State private var items = Array(1...20) // Initial items
    @State private var isLoading = false
    var productList: [String] = []
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                    Text("Paolo Campanile")
                        .padding(.bottom,20)
                        .padding(.leading, 10)
                        .font(.title2)
                        .bold()
                    
                }
                Spacer()
            }
            .padding()
            if productList.isEmpty {
                
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(items, id: \.self) { item in
                            KFImage(URL(string: profile.profileImageURL)) //uso KFImage per caricare l'immagine in ogni cella della griglia
                                .resizable()
                                .scaledToFill() // per scalare l'immagine
                                .frame(height: 160) // per l'altezza del rettangolo nella griglia
                                .cornerRadius(20)
                            
                                .cornerRadius(10)
                        }
                        
                        // Show loading indicator at the end of the list
                        if isLoading {
                            ProgressView()
                                .padding()
                                .onAppear {
                                    loadMoreData()
                                }
                        }
                    }
                    .padding()
                }
                .onAppear {
                    loadMoreData() // Load initial data
                }
            }
            
            
            
            Spacer()
            
            Button(action: {
                // Action for Ask Info
            }) {
                Text("Ask Info ♡")
            }
            .buttonStyle(PrimaryButtonStyle())
            
        }
    }

    
    
    func loadMoreData() {
        guard !isLoading else { return }
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let moreItems = Array(items.count + 1...items.count + 20)
            items.append(contentsOf: moreItems)
            isLoading = false
        }
    }
}



#Preview {
    ProfileView(profile: Profile(name: "Paola", surname: "Campanile", email: "paula@campanile.com", about: "Second-hand enthusiast 🌱 ", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png"))
}
