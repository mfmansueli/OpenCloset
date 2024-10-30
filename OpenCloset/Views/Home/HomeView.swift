//
//  HomeView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            
            
            HStack {
                Text("9:41")
                    .font(.system(size: 20))
                    .padding(.leading, 10)
                Spacer()
                Image(systemName: "battery.100")
                    .padding(.trailing, 10)
            }
            .padding(.top, 10)
            
            HStack {
                TextField("Search", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                Image(systemName: "magnifyingglass")
                    .padding(.trailing, 10)
            }
            .background(Color.yellow)
            
            Text("Sort by: Distance")
                .padding(.leading, 10)
                .padding(.top, 10)
            
            ScrollView {
                VStack(alignment: .leading) {
                    UserRow(name: "Paola", distance: "150 m", rating: 3, description: "Second-hand enthusiast 🌱")
                    UserRow(name: "Giorgia", distance: "70 m", rating: 2, description: "New to second hand.")
                    UserRow(name: "Paola", distance: "150 m", rating: 3, description: "Second-hand enthusiast 🌱")
                    UserRow(name: "Giorgio", distance: "70 m", rating: 2, description: "New to second hand.")
                    UserRow(name: "Paola", distance: "150 m", rating: 3, description: "Second-hand enthusiast 🌱")
                }
                .padding(.horizontal, 10)
            }
            
        }
    }
}

struct UserRow: View {
    var name: String
    var distance: String
    var rating: Int
    var description: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                HStack {
                    Text(distance)
                        .padding(5)
                        .background(Color.pink)
                        .cornerRadius(5)
                    ForEach(0..<rating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                Text(description)
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    HomeView()
}
