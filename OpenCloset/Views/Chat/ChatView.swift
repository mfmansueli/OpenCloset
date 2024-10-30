//
//  ChatView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel = ChatViewModel()
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    ChatView()
}
