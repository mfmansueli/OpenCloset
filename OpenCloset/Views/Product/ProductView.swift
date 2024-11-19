//
//  ProductView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI
import Kingfisher

struct ProductView: View {
    @EnvironmentObject var tabSelection: TabSelection
    var product: Product
    var owner: Profile
    
    var body: some View {
        VStack {
            TabView {
                ForEach(product.imageURLs, id: \.self) { imageUrl in
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .placeholder{
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.accent))
                        }
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
                }
            }
            .frame(height: 350)
            .tabViewStyle(PageTabViewStyle())
            
            // Hat title
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Action buttons
                if product.isSwap || product.isDonate {
                    HStack {
                        if product.isSwap {
                            Text("Swap")
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundColor(.white)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(Color.accent)
                                .cornerRadius(8)
                        }
                        
                        if product.isDonate {
                            Text("Donate")
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundColor(.white)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(Color.accent)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.bottom, 5)
                }
                // Details about the hat
                Text("Condition: \(product.condition)")
                Text("Size: \(product.size)")
                
                VStack(alignment: .leading) {
                    Text("Item description")
                        .font(.headline)
                        .padding(.top, 1)
                    Text(product.itemDescription)
                }
                
                
                Spacer()
                
                if let loggedUserProfile = AppDefault.loadObject(type: Profile.self, key: .userProfile),
                   loggedUserProfile.id != product.userID {
                    Button {
                        tabSelection.productID = product.id
                        tabSelection.ownerID = product.userID
                        tabSelection.ownerImageURL = owner.profileImageURL
                        tabSelection.ownerName = owner.name
                        
                        tabSelection.requestID = loggedUserProfile.id
                        tabSelection.requestImageURL = loggedUserProfile.profileImageURL
                        tabSelection.requestName = loggedUserProfile.name
                        tabSelection.selectedTab = 2
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
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}


#Preview {
    ProductView(product: Product(userID: "12345", name: "Hat", size: "M", condition: "New", itemDescription: "This is a hat", imageURLs: ["https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png", "https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png", "https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"], isDonate: true, isSwap: false),
                owner: Profile(id: "12345", name: "Mateus", surname: "Santos", email: "", about: "", profileImageURL: "https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png"))
}
