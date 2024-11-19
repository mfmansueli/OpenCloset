//
//  ProfileView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI
import Kingfisher
import FirebaseAuth

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel()
    var profile: Profile
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: profile.profileImageURL))
                    .resizable()
                    .placeholder{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.accent))
                    }
                    .scaledToFill()
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color .white, lineWidth: 2))
                    .padding(.leading, 20)
                VStack(alignment: .leading) {
                    Text("\(profile.name) \(profile.surname)")
                        .padding(.bottom,3)
                        .padding(.leading, 0)
                        .font(.title2)
                        .bold()
                    HStack {
                        Text("150 m")
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(.accent)
                            .font(.system(size: 20))
                            .padding(.trailing, 20)
                        HStack {
                            ForEach(0..<3, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .frame(width: 12, height: 20)
                            }
                        }
                        
                    }
                    
                }
                Spacer()
            }
            .padding(.bottom, 5)
            
            .padding()
            
            if viewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView("Loading products...")
                        .padding()
                    Spacer()
                }
            } else if viewModel.productList.isEmpty {
                EmptyStateView(imageName: "hanger", subtext: emptyStateMessage)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.productList, id: \.self) { product in
                            NavigationLink(destination: ProductView(product: product, owner: profile)) {
                                KFImage(URL(string: product.imageURLs.first ?? ""))
                                    .resizable()
                                    .fade(duration: 0.25)
                                    .placeholder{
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: Color.accent))
                                    }
                                    .scaledToFill()
                                    .frame(height: 160)
                                    .shadow(radius: 10)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding()
                }
            }
            
            Spacer()
            if isCurrentUser {
                NavigationLink(destination: AddProductView(onAddProductCompletion:
                                                            { product in
                    viewModel.addProduct(product: product)
                })) {
                    Button(action: {
                    }) {
                        Text("Add clothes")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .allowsHitTesting(false)
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            viewModel.fetchProducts(userID: profile.id)
        }
    }
    
    var isCurrentUser: Bool {
        if let loggedUserProfile = AppDefault.loadObject(type: Profile.self, key: .userProfile),
           loggedUserProfile.id == profile.id {
            return true
        }
        return false
    }
    
    var emptyStateMessage: String {
        isCurrentUser ? "Your OpenCloset is empty" : "\(profile.name)'s OpenCloset is empty."
    }
}

#Preview {
    ProfileView(profile: Profile(name: "Paola", surname: "Campanile", email: "paula@campanile.com", about: "Second-hand enthusiast 🌱 ", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png"))
}
