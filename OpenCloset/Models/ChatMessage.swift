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
    var senderID: String
    var senderImageURL: String
    var content: String
    var timestamp: TimeInterval
    
    init(id: String = UUID().uuidString, senderID: String, senderImageURL: String, content: String, timestamp: TimeInterval = Date().timeIntervalSince1970) {
        self.id = id
        self.senderID = senderID
        self.senderImageURL = senderImageURL
        self.content = content
        self.timestamp = timestamp
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let senderID = value["senderID"] as? String,
            let senderImageURL = value["senderImageURL"] as? String,
            let content = value["content"] as? String,
            let timestamp = value["timestamp"] as? TimeInterval else {
            return nil
        }
        self.id = snapshot.key
        self.senderID = senderID
        self.senderImageURL = senderImageURL
        self.content = content
        self.timestamp = timestamp
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "senderID": senderID,
            "senderImageURL": senderImageURL,
            "content": content,
            "timestamp": timestamp
        ]
    }
}
