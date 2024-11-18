//
//  Channel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 17/11/24.
//
import Foundation
import FirebaseDatabase

struct Channel: Identifiable, Codable {
    var id: String
    var name: String
    var lastMessage: ChatMessage?
    var messages: [ChatMessage]
    
    init(id: String = UUID().uuidString, name: String, messages: [ChatMessage] = []) {
        self.id = id
        self.name = name
        self.messages = messages
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: AnyObject],
              let name = value["name"] as? String else {
            return nil
        }
        self.id = snapshot.key
        self.name = name
        self.messages = []
    }
}
