//
//  ChatView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//
import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel = ChatViewModel()
    
    var channel: Channel
    
    init(channel: Channel) {
        self.channel = channel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ChatHeaderView(productId: channel.productID)
                .background(Color.clear)
            
            List(viewModel.messages) { message in
                HStack {
                    if isCurrentUser(message.senderID) {
                        ChatBubbleView(message: message.content, alignment: .trailing)
                            .background(Color.clear)
                        ChatProfileView(senderID: message.senderID,
                                        senderImageURL: message.senderImageURL)
                        .background(Color.clear)
                    } else {
                        ChatProfileView(senderID: message.senderID,
                                        senderImageURL: message.senderImageURL)
                        .background(Color.clear)
                        
                        ChatBubbleView(message: message.content, alignment: .leading)
                            .background(Color.clear)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .listRowSeparator(.hidden)
            }.listStyle(.plain)
                .scrollDismissesKeyboard(.immediately)
            
            HStack {
                TextField("Message", text: $viewModel.message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 54)
                
                if !viewModel.message.isEmpty {
                    Button(action: {
                        viewModel.sendMessage(for: channel.id)
                    }) {
                        Text("Send")
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .frame(height: 45)
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding(.leading, 8)
                    .padding(.vertical, 4)
                    .transition(.slide)
                    .animation(.easeOut, value: viewModel.message)
                }
            }
            .padding(.horizontal, 16)
            .background(Color.gray.opacity(0.1))
        }.onAppear {
            viewModel.fetchMessages(for: channel.id)
        }
    }
    
    func isCurrentUser(_ userID: String) -> Bool {
        if let loggedUserProfile = AppDefault.loadObject(type: Profile.self, key: .userProfile),
           userID == loggedUserProfile.id {
            return true
        }
        return false
    }
}
