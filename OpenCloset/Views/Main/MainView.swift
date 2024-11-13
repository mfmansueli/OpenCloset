//
//  MainView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 31/10/24.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @State private var selection: Int = 1
    @State private var showLoginSheet: Bool = false
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
            
            let user = Auth.auth().currentUser
            NavigationStack {
                ProfileView(profile: Profile(id: user?.uid ?? "", name: user?.displayName ?? "", surname: "", email: user?.email ?? "", about: "Second-hand enthusiast 🌱 ", profileImageURL: user?.photoURL?.absoluteString ?? ""))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("", systemImage: "arrowshape.turn.up.left") {
                                do {
                                    try Auth.auth().signOut()
                                    selection = 1
                                } catch {
                                    
                                }
                            }
                        }
                    }
                
            }.tabItem {
                Image(systemName: "person.crop.circle")
            }.tag(3)
        }
        .onChange(of: selection, { oldValue, newValue in
            if Auth.auth().currentUser == nil, newValue == 2 || newValue == 3 {
                tempSelection = newValue
                showLoginSheet = true
                selection = oldValue
            }
        })
        .sheet(isPresented: $showLoginSheet) {
            LoginView(selection: $selection).presentationDetents([.medium, .large])
        }
    }
}


#Preview {
    MainView()
}
