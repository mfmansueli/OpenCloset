//
//  ChatBubbleView.swift
//  OpenCloset
//
//  Created by Giorgio Durante on 12/11/24.
//

import SwiftUI

struct ChatBubbleView: View {
    var message: String = ""
    var alignment: Alignment
    var body: some View {
        Text(message)
            .padding(10)
            .background(.linePink)
            .foregroundColor(.black)
            .clipShape(
                .rect(
                    topLeadingRadius: 16,
                    bottomLeadingRadius: alignment == .leading ? 0 : 16,
                    bottomTrailingRadius: alignment == .trailing ? 0 : 16,
                    topTrailingRadius: 16
                )
            )
            .frame(maxWidth: 250, alignment: alignment)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
    }
}

#Preview {
    ChatBubbleView(message: "Ciao bella bionda!", alignment: .trailing)
}
