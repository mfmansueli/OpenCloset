//
//  ChatView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel = ChatViewModel()
    @State private var selection: Int = 1
    var messages: [String] = []
    var body: some View {
        NavigationStack {
            VStack {
                if messages.isEmpty {
                    EmptyStateView(imageName: "envelope")
                } else {
                    Text("Hello, World!")
                }
                
            }.navigationTitle("Chat")
        }
    }
}

#Preview {
    ChatView()
}
