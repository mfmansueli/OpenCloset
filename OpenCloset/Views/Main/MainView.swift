//
//  MainView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 31/10/24.
//

import SwiftUI

struct MainView: View {
    @State private var selection: Int = 1
    @State private var showLoginSheet: Bool = false
    @State private var isLoggedIn: Bool = false // This should be replaced with actual authentication status
    @State private var tempSelection: Int? = nil

    var body: some View {
        TabView(selection: $selection) {
            HomeView().tabItem {
                Image(systemName: "tshirt")
            }.tag(1)
            
            ChatView().tabItem {
                Image(systemName: "envelope")
            }
            .tag(2)
            
            ProfileView(profile: Profile(name: "Paola", surname: "Campanile", email: "paula@campanile.com", about: "Second-hand enthusiast 🌱 ", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png")).tabItem {
                Image(systemName: "person.crop.circle")
            }.tag(3)
        }
        .onChange(of: selection, { oldValue, newValue in
            if newValue == 2 || newValue == 3 && !isLoggedIn {
                tempSelection = newValue
                showLoginSheet = true
                selection = oldValue
            }
        })
        .sheet(isPresented: $showLoginSheet) {
            LoginView().presentationDetents([.medium, .large])
        }
    }
}


#Preview {
    MainView()
}
