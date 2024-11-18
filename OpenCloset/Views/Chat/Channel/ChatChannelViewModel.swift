//
//  ChatChannelViewModel.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 17/11/24.
//
import Foundation
import FirebaseDatabase

class ChatChannelViewModel: ObservableObject {
    @Published var channels: [Channel] = []
    
    init() {
        fetchChannels()
    }
    
    func fetchChannels() {
        let ref = Database.database().reference().child("channels")
        ref.observe(.value) { snapshot in
            var newChannels: [Channel] = []
            let dispatchGroup = DispatchGroup()

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let channel = Channel(snapshot: snapshot) {
                    dispatchGroup.enter()
                    self.fetchLastMessage(for: channel.id) { message in
                        var updatedChannel = channel
                        updatedChannel.lastMessage = message
                        newChannels.append(updatedChannel)
                        dispatchGroup.leave()
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                self.channels = newChannels
            }
        }
    }
    
    func fetchLastMessage(for channelID: String, completion: @escaping (ChatMessage?) -> Void) {
        let messagesRef = Database.database().reference().child("channels").child(channelID).child("messages")
        messagesRef.queryOrdered(byChild: "timestamp").queryLimited(toLast: 1).observeSingleEvent(of: .value) { snapshot in
            if let child = snapshot.children.allObjects.first as? DataSnapshot,
               let message = ChatMessage(snapshot: child) {
                completion(message)
            } else {
                completion(nil)
            }
        }
    }
}

