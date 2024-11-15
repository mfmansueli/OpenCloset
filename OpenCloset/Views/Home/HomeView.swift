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
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search", text: $viewModel.searchText)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                    
                    Image(systemName: "magnifyingglass")
                        .padding(.trailing, 10)
                }
                List(viewModel.filteredItems) { profile in
                    NavigationLink(destination: ProfileView(profile: profile)) {
                        ProfileItemView(profile: profile)
                    }
                }.refreshable {
                    viewModel.page = 1
                }.scrollDismissesKeyboard(.immediately)
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
