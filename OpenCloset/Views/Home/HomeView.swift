//
//  HomeView.swift
//  OpenCloset
//
//  Created by Iago Xavier de Lima on 11/11/24.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    var listProfiles: [Profile] = [
        Profile(name: "Mateus", surname: "Mansuelli", email: "mateus.mansuelli@gmail.com", about: "Hello, I'm Mateus", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png"),
        Profile(name: "Mateus", surname: "Mansuelli", email: "mateus.mansuelli@gmail.com", about: "Hello, I'm Mateus", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png"),
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search", text: .constant(""))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                    Image(systemName: "magnifyingglass")
                        .padding(.trailing, 10)
                    
                }
                List(viewModel.items) { profile in
                    
                    ProfileItemView(profile: profile)
                    
                    
                }
            }
        }
    
    }
}

#Preview {
    HomeView()
}

struct ProfileItemView: View {
    var profile: Profile
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(profile.name) \(profile.surname)")
                    .font(.headline)
                
                HStack {
                    Text("100m")
                        .padding(5)
                        .background(Color.pink)
                        .cornerRadius(5)
                    ForEach(0..<3, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                Text(profile.about)
                    .font(.subheadline)
            }
            Spacer()
            KFImage(URL(string: profile.profileImageURL))
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
        }
        .padding(.vertical, 5)
    }
}
