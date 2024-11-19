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
import Firebase
import GoogleSignIn

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
    var onLoginCompletion: (() -> Void)?
    
    init(selection: Binding<Int>) {
        self.selection = selection
    }
    
    func loginWithFacebook() {
        do {
            try Auth.auth().signOut()
        } catch {
            showAlert(message: "Error signing out: \(error.localizedDescription)")
        }
        
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
            guard let self = self else { return }
            if let error = error {
                self.showAlert(message: "Failed to fetch user profile: \(error.localizedDescription)")
                return
            }
        
            if let userData = result as? [String: Any] {
                self.id = Auth.auth().currentUser?.uid ?? ""
                self.email = userData["email"] as? String ?? ""
                self.name = userData["first_name"] as? String ?? ""
                self.surname = userData["last_name"] as? String ?? ""
                self.profileImageURL = ((userData["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String ?? ""
                
                loadUserProfile(by: self.id)
            }
        }
    }
    
    func loginWithGoogle() {
        do {
            try Auth.auth().signOut()
        } catch {
            showAlert(message: "Error signing out: \(error.localizedDescription)")
        }
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            showAlert(message: "Unable to find root view controller")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            if let error = error {
                self?.showAlert(message: "Google sign-in failed: \(error.localizedDescription)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                self?.showAlert(message: "Google sign-in failed: No authentication token")
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                if let error = error {
                    self?.showAlert(message: "Firebase login failed: \(error.localizedDescription)")
                } else {
                    self?.fetchGoogleUserProfile(user: user)
                }
            }
        }
    }

    private func fetchGoogleUserProfile(user: GIDGoogleUser?) {
        guard let user = user else { return }

        self.id = Auth.auth().currentUser?.uid ?? ""
        self.email = user.profile?.email ?? ""
        self.name = user.profile?.givenName ?? ""
        self.surname = user.profile?.familyName ?? ""
        self.profileImageURL = user.profile?.imageURL(withDimension: 200)?.absoluteString ?? ""

        loadUserProfile(by: self.id)
    }
    
    func loadUserProfile(by id: String) {
        let collection = Firestore.firestore().collection("Profiles")
        
        collection.document(self.id).getDocument { (document, error) in
            if let error = error {
                self.showAlert(message: "Error fetching user profile: \(error.localizedDescription)")
                return
            }
            
            self.isLoading = false
            if let document = document, document.exists {
                do {
                    var profile = try document.data(as: Profile.self)
                    profile.id = document.documentID
                    AppDefault.saveObject(value: profile, key: .userProfile)
                    self.onLoginCompletion?()
                } catch(let error) {
                    self.showAlert(message: "Error decoding profile: \(error.localizedDescription)")
                }
                return
            }
            
            self.showRegister = true
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
        isLoading = false
    }
}
