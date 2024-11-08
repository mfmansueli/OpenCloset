//
//  ClearableTextField.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//
import SwiftUI

struct ClearableTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding()
            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.accent)
            }
            .padding(.trailing)
        }
        .background(Color(red: 1.0, green: 0.9, blue: 0.9))
        .padding(.bottom, 16)
    }
}

#Preview {
    @Previewable @State var text = "Example text"
    
    ClearableTextField(text: $text, placeholder: "Enter something...")
}
