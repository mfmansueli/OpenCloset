//
//  LoginView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct LoginView: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Text("Login with Facebook")
                .font(.largeTitle)
                .padding()
                .background(Color.blue)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    LoginView()
}
