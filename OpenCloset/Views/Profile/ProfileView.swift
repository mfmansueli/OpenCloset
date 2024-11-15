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
    @ObservedObject var viewModel: ProfileViewModel = ProfileViewModel()
    var profile: Profile
    @State private var isLoading = false
    @State var isCurrentUser = false
    var productList: [Product] = [
        Product(size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                    true, isSwapping: false),
        Product(size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                    true, isSwapping: false),
        Product(size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                    true, isSwapping: false),
        Product(size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                    true, isSwapping: false),
        Product(size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                    true, isSwapping: false),
        Product(size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                    true, isSwapping: false),
        Product(size: "P" , condition: "new", description: "uhashuas", image: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonation:
                    true, isSwapping: false)
    ]
    
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: profile.profileImageURL))
                    .resizable()
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
                                    .foregroundColor(.accent)
                            }
                        }

                    }
                    
                }
                Spacer()
            }
            .padding(.bottom, 5)

            .padding()
            if productList.isEmpty {
                EmptyStateView(imageName: "hanger", subtext: "Your Open Closet is empty")
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(productList, id: \.self) { product in
                            NavigationLink(destination: ProductView()) {
                                KFImage(URL(string: product.image.first ?? "")) //uso KFImage per caricare l'immagine in ogni cella della griglia
                                    .placeholder({
                                        Image(systemName: "clothes")
                                    })
                                    .resizable()
                                    .scaledToFill() // per scalare l'immagine
                                    .frame(height: 160) // per l'altezza del rettangolo nella griglia
                                    .cornerRadius(20)
                                
                                    .cornerRadius(10)
                            }
                        }
                        
                        // Show loading indicator at the end of the list
                        if isLoading {
                            ProgressView()
                                .padding()
                        }
                    }
                    .padding()
                }
            }
            
            Spacer()
            if Auth.auth().currentUser != nil {
                NavigationLink(destination: AddProductView()) {
                    Button(action: {
                    }) {
                        Text("Add clothes")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .allowsHitTesting(false)
                }
            } else {
                Button(action: {
                    // Action for Ask Info
                }) {
                    Text("Ask Info ♡")
                }
                .buttonStyle(PrimaryButtonStyle())
            }
        }.navigationTitle("Closet")
    }
}



#Preview {
    ProfileView(profile: Profile(name: "Paola", surname: "Campanile", email: "paula@campanile.com", about: "Second-hand enthusiast 🌱 ", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png"))
}
