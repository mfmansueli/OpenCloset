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
                Label("home", systemImage: "tshirt")
            }.tag(1)
            
            ChatView().tabItem {
                Label("chat", systemImage: "envelope")
            }
            .tag(2)
            
            NavigationStack {
                if let profile = AppDefault.loadObject(type: Profile.self, key: .userProfile) {
                    ProfileView(profile: profile)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("", systemImage: "rectangle.portrait.and.arrow.right") {
                                    do {
                                        try Auth.auth().signOut()
                                        selection = 1
                                    } catch {
                                        
                                    }
                                }
                            }
                        }
                } else {
                    EmptyView()
                }
            }.tabItem {
                Label("profile", systemImage: "person.crop.circle")
            }.tag(3)
        }
        .onChange(of: selection, { oldValue, newValue in
            if AppDefault.loadObject(type: Profile.self, key: .userProfile) == nil, newValue == 2 || newValue == 3 {
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
