//
//  HomeView.swift
//  OpenCloset
//
//  Created by Iago Xavier de Lima on 11/11/24.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color.gray.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)  // Ensuring it covers the whole background
                
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
                    .frame(height: 50)
                    
                    List(viewModel.filteredItems) { profile in
                        NavigationLink(destination: ProfileView(profile: profile)) {
                            ProfileItemView(profile: profile)
                        }
                    }
                    .refreshable {
                        viewModel.page = 1
                    }
                    .scrollDismissesKeyboard(.immediately)
                    .scrollContentBackground(.hidden)
                    
                }
//                Spacer()
//                    .background(Color.gray.opacity(0.1))
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
                    .lineLimit(1)
                    .font(.system(size: 20))
                
                HStack {
                    Text(profile.distance)
                        .lineLimit(1)
                        .foregroundColor(.accent)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .font(.system(size: 20))
                        .padding(.trailing, 17)
                    
                
                    
                    ForEach(0..<3, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .frame(width: 12, height: 20)
                    }
                }
                Text(profile.about)
                    .lineLimit(1)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(.black)
            }
            Spacer()
            KFImage(URL(string: profile.profileImageURL))
                .resizable()
                .placeholder{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.accent))
                }
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
        }
        .padding(.vertical, 5)
    }
}
