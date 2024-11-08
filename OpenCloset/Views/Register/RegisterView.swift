//
//  RegisterView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = "paolacampanile@gmail.com"
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var about: String = ""
    @State private var showCamera: Bool = false
    
    @ObservedObject var viewModel: RegisterViewModel = RegisterViewModel()
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                
                // Profile Icon
                Circle()
                    .strokeBorder(Color.accent2, lineWidth: 4)
                    .background(Circle().foregroundColor(.white))
                    .overlay(
                        Image(systemName: "person.crop.circle.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.accentColor)
                            .padding(80)
                            .onTapGesture {
                                showCamera = true
                            }
                    )
                    .frame(width: 250, height: 250)
                    .padding(.bottom, 48)
                    .sheet(isPresented: $showCamera, content: {
                        ImageCaptureView(image: $viewModel.profileImage)
                    })
                
                
                ClearableTextField(text: $email, placeholder: "Email")
                ClearableTextField(text: $name, placeholder: "Name")
                ClearableTextField(text: $surname, placeholder: "Surname")
                ClearableTextField(text: $about, placeholder: "About you")
                
                Spacer()
                
                Button("Register") {
//                    viewModel.register
                }.buttonStyle(PrimaryButtonStyle())
            }
            .padding(.top, 50)
        }
    }
}

#Preview {
    RegisterView()
}
