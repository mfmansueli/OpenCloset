//
//  ChatViewModel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//
import SwiftUI
import FirebaseDatabase
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var message: String = ""
    private var ref: DatabaseReference = Database.database().reference()
    private var messagesRef: DatabaseReference?
    
    func fetchMessages(for channelID: String) {
        messagesRef = ref.child("channels").child(channelID).child("messages")
        messagesRef?.queryOrdered(byChild: "timestamp").observe(.value) { snapshot in
            var newMessages: [ChatMessage] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let message = ChatMessage(snapshot: snapshot) {
                    newMessages.append(message)
                }
            }
            self.messages = newMessages
        }
    }
    
    func sendMessage(for channelID: String) {
        if message.isEmpty { return }
        guard let loggedUserProfile = AppDefault.loadObject(type: Profile.self, key: .userProfile) else { return }
    
        let message = ChatMessage(senderID: loggedUserProfile.id, senderImageURL: loggedUserProfile.profileImageURL, content: message)
        let messageRef = ref.child("channels").child(channelID).child("messages").child(message.id)
        messageRef.setValue(message.toDictionary())
        self.message = ""
    }
}
