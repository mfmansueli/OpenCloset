//
//  RegisterView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI
import Kingfisher

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(name: String, surname: String, email: String, profileImageURL: String?) {
        viewModel = RegisterViewModel(name: name, surname: surname, email: email, profileImageURL: profileImageURL)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack {
                        if let profileImageURL = viewModel.profileImageURL {
                            KFImage(URL(string: profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 250)
                                .clipShape(Circle())
                                .overlay(Circle().strokeBorder(Color.yellow, lineWidth: 4)
                                    .frame(width: 250, height: 250))
                                .padding(.bottom, 48)
                                .onTapGesture {
                                    viewModel.showPhotoOptions = true
                                }
                        } else if let profileImage = viewModel.profileImage {
                            // Display the profile image if available
                            
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 250)
                                .clipShape(Circle())
                                .overlay(Circle().strokeBorder(Color.yellow, lineWidth: 4)
                                    .frame(width: 250, height: 250))
                                .padding(.bottom, 48)
                                .onTapGesture {
                                    viewModel.showPhotoOptions = true
                                }
                        } else {
                            // Default overlay when no profile image is available
                            Circle()
                                .strokeBorder(Color.yellow, lineWidth: 4)
                                .background(Circle().foregroundColor(.white))
                                .overlay(
                                    Image(systemName: "person.crop.circle.badge.plus")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.orange)
                                        .padding(80)
                                        .onTapGesture {
                                            viewModel.showPhotoOptions = true
                                        }
                                )
                                .frame(width: 250, height: 250)
                                .padding(.bottom, 48)
                        }
                    }
                    .confirmationDialog("", isPresented: $viewModel.showPhotoOptions, titleVisibility: .hidden, actions: {
                        Button("Take a photo") {
                            viewModel.showCamera = true
                        }
                        Button("Choose from library") {
                            viewModel.showPhotoLibrary = true
                        }
                    })
                    .fullScreenCover(isPresented: $viewModel.showCamera, content: {
                        ZStack {
                            Color.black.edgesIgnoringSafeArea(.all)
                            ImageCaptureView(image: $viewModel.profileImage)
                        }
                    })
                    .fullScreenCover(isPresented: $viewModel.showPhotoLibrary, content: {
                        ImagePickerView(images: .constant([]), image: $viewModel.profileImage, allowMultipleSelection: false)
                    })
                    .padding()
                    
                    ClearableTextField(text: $viewModel.email, placeholder: "Email", errorMessage: viewModel.emailError, keyboardType: .emailAddress, textContentType: .emailAddress)
                    ClearableTextField(text: $viewModel.name, placeholder: "Name", errorMessage: viewModel.nameError, textContentType: .givenName)
                    ClearableTextField(text: $viewModel.surname, placeholder: "Surname", errorMessage: viewModel.surnameError, textContentType: .familyName)
                    ClearableTextField(text: $viewModel.about, placeholder: "About you")
                    
                    Spacer()
                    
                    Button("Register") {
                        viewModel.register()
                    }.buttonStyle(PrimaryButtonStyle())
                }
                .padding(.top, 16)
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationBarTitle("Register", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .onAppear {
            viewModel.onRegisterCompletion = {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    RegisterView(name: "", surname: "", email: "", profileImageURL: "")
}
