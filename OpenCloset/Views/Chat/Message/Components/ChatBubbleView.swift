//
//  ChatBubbleView.swift
//  OpenCloset
//
//  Created by Giorgio Durante on 12/11/24.
//

import SwiftUI

struct ChatBubbleView: View {
    var message: String = "Ciao bella bionda!"
    var backgroundColor: Color = Color("LinePink")
    var alignment: Alignment
    var body: some View {
        Text(message)
            .padding(10)
            .background(backgroundColor)
            .foregroundColor(.black)
            .cornerRadius(15)
            .frame(maxWidth: 250, alignment: alignment)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
    }
}

#Preview {
    ChatBubbleView(alignment: .trailing)
}
