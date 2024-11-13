//
//  RegisterViewModel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth


class RegisterViewModel: ObservableObject {
    
    @Published var profileImage: UIImage? { didSet { profileImageURL = nil } }
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var about: String = ""
    
    @Published var showCamera: Bool = false
    @Published var emailError: String?
    @Published var nameError: String?
    @Published var surnameError: String?
    
    var profileImageURL: String?
    
    init(name: String, surname: String, email: String, profileImageURL: String?) {
        self.name = name
        self.surname = surname
        self.email = email
        self.profileImageURL = profileImageURL
    }
    
    func register() {
        guard validateInputs() else {
            return
        }
        
        if let image = profileImage {
            let imageName = UUID().uuidString
            let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(imageName).jpg")
            
            do {
                try image.jpegData(compressionQuality: 0.8)?.write(to: fileURL)
                print("Image saved successfully to \(fileURL.path)")
                
                let storageRef = Storage.storage().reference().child("profile_images/\(imageName).jpg")
                
                storageRef.putFile(from: fileURL, metadata: nil) { metadata, error in
                    if let error = error {
                        print("Error uploading file: \(error.localizedDescription)")
                        return
                    }
                    
                    storageRef.downloadURL { url, error in
                        if let error = error {
                            print("Error getting download URL: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let downloadURL = url else {
                            print("Download URL not found")
                            return
                        }
                        
                        self.saveProfileData(profileImageURL: downloadURL.absoluteString)
                    }
                }
            } catch {
                print("Error writing image to file: \(error.localizedDescription)")
            }
        } else {
            self.saveProfileData(profileImageURL: profileImageURL)
        }
    }
    
    private func saveProfileData(profileImageURL: String?) {
        let collection = Firestore.firestore().collection("Profiles")
        
        var profileData: [String: Any] = [
            "name": self.name,
            "surname": self.surname,
            "email": self.email,
            "about": self.about
        ]
        
        
        
        if let imageUrl = profileImageURL {
            profileData["profileImageURL"] = imageUrl
        }
        
        collection.addDocument(data: profileData) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added successfully!")
            }
        }
    }
    
    private func validateInputs() -> Bool {
        var isValid = true
        
        if name.isEmpty {
            nameError = "Name cannot be empty."
            isValid = false
        } else {
            nameError = nil
        }
        
        if surname.isEmpty {
            surnameError = "Surname cannot be empty."
            isValid = false
        } else {
            surnameError = nil
        }
        
        if email.isEmpty {
            emailError = "Email cannot be empty."
            isValid = false
        } else if !isValidEmail(email) {
            emailError = "Invalid email address."
            isValid = false
        } else {
            emailError = nil
        }
        
        return isValid
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
