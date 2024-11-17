//
//  ChatMessage.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 17/11/24.
//
import Foundation
import FirebaseDatabase

struct ChatMessage: Identifiable, Codable {
    var id: String
    var sender: String
    var content: String
    var timestamp: TimeInterval
    
    init(id: String = UUID().uuidString, sender: String, content: String, timestamp: TimeInterval = Date().timeIntervalSince1970) {
        self.id = id
        self.sender = sender
        self.content = content
        self.timestamp = timestamp
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let sender = value["sender"] as? String,
            let content = value["content"] as? String,
            let timestamp = value["timestamp"] as? TimeInterval else {
            return nil
        }
        self.id = snapshot.key
        self.sender = sender
        self.content = content
        self.timestamp = timestamp
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "sender": sender,
            "content": content,
            "timestamp": timestamp
        ]
    }
}
