//
//  MainView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 31/10/24.
//

import SwiftUI

struct MainView: View {
    @State private var selection: Int = 1
    var body: some View {
        TabView(selection: $selection) {
            HomeView().tabItem {
                Image(systemName: "tshirt")
            }.tag(1)
            RegisterView().tabItem {
                Image(systemName: "tshirt")
            }.tag(2)
            ChatView().tabItem {
                Image(systemName: "envelope")
            }.tag(3)
            ProfileView(profile: Profile(name: "Paola", surname: "Campanile", email: "paula@campanile.com", about: "Second-hand enthusiast 🌱 ", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png")).tabItem {
                Image(systemName: "person.crop.circle")
            }.tag(4)
            
        }
    }
}

#Preview {
    MainView()
}
