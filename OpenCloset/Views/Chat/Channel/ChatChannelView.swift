//
//  ChatChannelView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 17/11/24.
//

import SwiftUI

struct ChatChannelView: View {
    @EnvironmentObject var tabSelection: TabSelection
    @ObservedObject var viewModel = ChatChannelViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.channels.isEmpty {
                    List(viewModel.channels) { channel in
                        NavigationLink {
                            ChatView(channel: channel)
                        } label: {
                            ChannelView(channel: channel)
                        }.listRowSeparatorTint(Color.accentColor)
                    }
                    .listStyle(.plain)
                    
                    .listRowSeparatorTint(.accent)
                    
                    
                } else {
                    EmptyStateView(imageName: "envelope", subtext: "Your chat is empty\nStart swapping! ")
                }
            }
            .navigationTitle("Chat")
        }.onAppear {
            viewModel.createChatChannel(productID: tabSelection.productID, ownerID: tabSelection.ownerID, requestID: tabSelection.requestID, ownerImageURL: tabSelection.ownerImageURL, requestImageURL: tabSelection.requestImageURL, ownerName: tabSelection.ownerName, requestName: tabSelection.requestName)
            
            tabSelection.productID = ""
            tabSelection.ownerID = ""
            tabSelection.ownerImageURL = ""
            tabSelection.ownerName = ""
            
            tabSelection.requestID = ""
            tabSelection.requestImageURL = ""
            tabSelection.requestName = ""
        }
    }
}

#Preview {
    ChatChannelView()
}

import Kingfisher
import SwiftUI

struct ChannelView: View {
    var channel: Channel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(channel.lastMessage?.content ?? "")
                    .lineLimit(1)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            KFImage(URL(string: profileImageURL))
                .resizable()
                .fade(duration: 0.25)
                .placeholder{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.accent))
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        }
    }
    
    
    var name: String {
        isCurrentUser ? channel.requestName : channel.ownerName
    }
    
    var profileImageURL: String {
        isCurrentUser ? channel.requestImageURL : channel.ownerImageURL
    }
    
    var isCurrentUser: Bool {
        if let loggedUserProfile = AppDefault.loadObject(type: Profile.self, key: .userProfile),
           channel.ownerID == loggedUserProfile.id {
            return true
        }
        return false
    }
}
