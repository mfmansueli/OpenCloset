//
//  LoginViewModel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import Foundation
import SwiftUI
import FacebookLogin
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showRegister = false
    @Published var isLoading = false
    var selection: Binding<Int>
    var id = ""
    var email = ""
    var name = ""
    var surname = ""
    var profileImageURL = ""
    
    init(selection: Binding<Int>) {
        self.selection = selection
    }
    func loginWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { [weak self] result, error in
            if result?.isCancelled ?? true {
                return
            }
            
            self?.isLoading = true
            if let error = error {
                self?.showAlert(message: "Facebook login failed: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = AccessToken.current else {
                self?.showAlert(message: "Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                if let error = error {
                    self?.showAlert(message: "Firebase login failed: \(error.localizedDescription)")
                } else {
                    self?.fetchFacebookUserProfile()
                }
            }
        }
    }
    
    private func fetchFacebookUserProfile() {
        let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, first_name, last_name, picture.type(large)"])
        request.start { [weak self] connection, result, error in
            if let error = error {
                self?.showAlert(message: "Failed to fetch user profile: \(error.localizedDescription)")
                return
            }
            
            if let userData = result as? [String: Any] {
                self?.id = userData["id"] as? String ?? ""
                self?.email = userData["email"] as? String ?? ""
                self?.name = userData["first_name"] as? String ?? ""
                self?.surname = userData["last_name"] as? String ?? ""
                self?.profileImageURL = ((userData["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String ?? ""
                self?.showRegister = true
                self?.isLoading = false
            }
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
        isLoading = false
    }
}
