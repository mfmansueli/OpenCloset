//
//  MainView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 31/10/24.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @StateObject private var tabSelection = TabSelection()
    @State private var showLoginSheet: Bool = false
    @State private var tempSelection: Int? = nil
    
    var body: some View {
        TabView(selection: $tabSelection.selectedTab) {
            HomeView().tabItem {
                Label("home", systemImage: "tshirt")
            }.tag(1)
            
            ChatChannelView().tabItem {
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
                                        AppDefault.removeObject(forKey: .userProfile)
                                        tabSelection.selectedTab = 1
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
        .onChange(of: tabSelection.selectedTab, { oldValue, newValue in
            if AppDefault.loadObject(type: Profile.self, key: .userProfile) == nil, newValue == 2 || newValue == 3 {
                tempSelection = newValue
                showLoginSheet = true
                tabSelection.selectedTab = oldValue
            }
        })
        .sheet(isPresented: $showLoginSheet) {
            LoginView(selection: $tabSelection.selectedTab).presentationDetents([.medium, .large])
        }
        .environmentObject(tabSelection)
    }
}


#Preview {
    MainView()
}
