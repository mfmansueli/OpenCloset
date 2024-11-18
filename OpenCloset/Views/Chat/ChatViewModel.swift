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
        messagesRef?.observe(.value) { snapshot in
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
    
    func sendMessage(to channelID: String, sender: String, content: String) {
        let message = ChatMessage(sender: sender, content: content)
        let messageRef = ref.child("channels").child(channelID).child("messages").child(message.id)
        messageRef.setValue(message.toDictionary())
    }
    
    func createChannel(name: String) {
        let newChannel = Channel(name: name)
        let channelRef = ref.child("channels").child(newChannel.id)
        channelRef.setValue(["name": name])
    }
}
