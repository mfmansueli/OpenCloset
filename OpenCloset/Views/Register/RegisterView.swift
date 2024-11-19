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
    
    init(id: String, name: String, surname: String, email: String, profileImageURL: String?) {
        viewModel = RegisterViewModel(id: id, name: name, surname: surname, email: email, profileImageURL: profileImageURL)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack {
                        if let profileImageURL = viewModel.profileImageURL {
                            KFImage(URL(string: profileImageURL))
                                .resizable()
                                .placeholder{
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: Color.accent))
                                }
                                .scaledToFill()
                                .frame(width: 250, height: 250)
                                .clipShape(Circle())
                                .overlay(Circle().strokeBorder(Color.textTitle, lineWidth: 4)
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
                                .overlay(Circle().strokeBorder(Color.textTitle, lineWidth: 4)
                                    .frame(width: 250, height: 250))
                                .padding(.bottom, 48)
                                .onTapGesture {
                                    viewModel.showPhotoOptions = true
                                }
                        } else {
                            Circle()
                                .strokeBorder(Color.textTitle, lineWidth: 4)
                                .background(Circle().foregroundColor(.white))
                                .overlay(
                                    Image(systemName: "person.crop.circle.badge.plus")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.textTitle)
                                        .padding(80)
                                        .padding(.trailing, 16)
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
                    
                    TextEditor(text: $viewModel.about)
                        .frame(height: 100)
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                        .padding(.leading, 16)
                        .padding(.top, 8)
                        .scrollContentBackground(.hidden)
                        .background {
                            ZStack(alignment: .topLeading) {
                                if viewModel.about.isEmpty {
                                    Text("About you")
                                        .padding(.leading, 19)
                                        .padding(.top, 16)
                                        .foregroundStyle(.gray.opacity(0.6))
                                }
                                RoundedRectangle(cornerRadius: 0)
                                    .foregroundStyle(Color.gray.opacity(0.2))
                            }
                        }
                    
                    
                    Spacer()
                    
                    Button("Register") {
                        viewModel.register()
                    }.buttonStyle(PrimaryButtonStyle())
                }
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
        .fullScreenCover(isPresented: $viewModel.isLoading) {
            ProgressView("Loading...")
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .presentationBackground(.black.opacity(0.4))
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            viewModel.onRegisterCompletion = {
                presentationMode.wrappedValue.dismiss()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    RegisterView(id: "", name: "", surname: "", email: "", profileImageURL: "")
}
