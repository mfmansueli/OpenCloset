//
//  ChatChannelView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 17/11/24.
//

import SwiftUI

struct ChatChannelView: View {
    @ObservedObject var viewModel = ChatChannelViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                ChatHeaderView()
                
                List(viewModel.channels) { channel in
                    NavigationLink {
                        ChatView(channel: channel)
                    } label: {
                        Text(channel.name)
                    }
                }
            }
            .navigationTitle("Chat")
        }
    }
}

#Preview {
    ChatChannelView()
}
