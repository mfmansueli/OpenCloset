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
    private var ref: DatabaseReference = Database.database().reference()
    private var messagesRef: DatabaseReference
    
    init() {
        messagesRef = ref.child("messages")
        fetchMessages()
    }
    
    func fetchMessages() {
        messagesRef.observe(.value) { snapshot in
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
    
    func sendMessage(sender: String, content: String) {
        let message = ChatMessage(sender: sender, content: content)
        let messageRef = messagesRef.child(message.id)
        messageRef.setValue(message.toDictionary())
    }
}
