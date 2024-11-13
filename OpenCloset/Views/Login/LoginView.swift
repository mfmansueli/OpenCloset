//
//  LoginView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI
struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(selection: Binding<Int>) {
        viewModel = LoginViewModel(selection: selection)
    }
    var body: some View {
        VStack(spacing: 16) {
            Text("🌿 Welcome to Open Closet!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.top, 32)
            
            Text("Join our community and start swapping clothes to reduce your carbon footprint. Every piece you swap helps the planet and revamps your wardrobe with unique, pre-loved treasures. It's a win-win for you and Mother Earth! 🌍👗♻️")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
            
            SocialLoginButton(imageName: "Facebook", buttonText: "Continue with Facebook") {
                viewModel.loginWithFacebook()
            }
            
            Button("not now, thanks") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(.black)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .fullScreenCover(isPresented: $viewModel.showRegister) {
            RegisterView(name: viewModel.name, surname: viewModel.surname, email: viewModel.email, profileImageURL: viewModel.profileImageURL)
        }
        .fullScreenCover(isPresented: $viewModel.isLoading) {
            ProgressView("Loading...")
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .presentationBackground(.black.opacity(0.4))
        }
    }
}


#Preview {
    LoginView(selection: .constant(0))
}
