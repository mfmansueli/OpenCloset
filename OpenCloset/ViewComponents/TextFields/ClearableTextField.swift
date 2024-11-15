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
    var errorMessage: String?
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .autocapitalization(.none)
                    .padding()
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.textTitle.opacity(0.7))
                }
                .padding(.trailing)
            }
            .background(Color.grayGiorgio)
            .padding(.bottom, 4)
            
            if let errorMessage = errorMessage, !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.leading, 8)
                    .padding(.bottom, 4)
            }
        }
        .padding(.bottom, 16)
    }
}

#Preview {
    @Previewable @State var text = "Example text"
    
    ClearableTextField(text: $text, placeholder: "Enter something...", errorMessage: "This is an error message")
}
