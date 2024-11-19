//
//  Channel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 17/11/24.
//
import Foundation
import FirebaseDatabase

struct Channel: Identifiable, Codable, Hashable {
    var id: String
    var productID: String
    var ownerID: String
    var requestID: String
    var ownerImageURL: String
    var requestImageURL: String
    var ownerName: String
    var requestName: String
    var lastMessage: ChatMessage?
    var messages: [ChatMessage]
    
    init(id: String, productID: String, ownerID: String, requestID: String, ownerImageURL: String, requestImageURL: String, ownerName: String, requestName: String, messages: [ChatMessage] = []) {
        self.id = id
        self.productID = productID
        self.ownerID = ownerID
        self.requestID = requestID
        self.ownerImageURL = ownerImageURL
        self.requestImageURL = requestImageURL
        self.ownerName = ownerName
        self.requestName = requestName
        self.lastMessage = nil
        self.messages = messages
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: AnyObject],
              let productID = value["productID"] as? String,
              let ownerID = value["ownerID"] as? String,
              let requestID = value["requestID"] as? String,
              let ownerImageURL = value["ownerImageURL"] as? String,
              let requestImageURL = value["requestImageURL"] as? String,
              let ownerName = value["ownerName"] as? String,
              let requestName = value["requestName"] as? String else {
            return nil
        }
        self.id = snapshot.key
        self.productID = productID
        self.ownerID = ownerID
        self.requestID = requestID
        self.ownerImageURL = ownerImageURL
        self.requestImageURL = requestImageURL
        self.ownerName = ownerName
        self.requestName = requestName
        self.lastMessage = nil // Will be fetched separately
        self.messages = [] // Messages will be fetched separately
    }
    
    static func == (lhs: Channel, rhs: Channel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
