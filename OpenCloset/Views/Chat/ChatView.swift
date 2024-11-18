//
//  ChatView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//
import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel = ChatViewModel()
    var channel: Channel

    var body: some View {
        VStack {
            
            ChatHeaderView()
            
            List(viewModel.messages) { message in
                HStack {
                    ChatProfileView(profile: message.profile)
                                    
                    
                    ChatBubbleView(alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
            }
            
            TextField("Message", text: $viewModel.message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(channel: Channel(name: ""))
    }
}
