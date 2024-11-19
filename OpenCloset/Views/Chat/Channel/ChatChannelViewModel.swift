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
    @Published var isLoading: Bool = false
    
    init() {
//        fetchChannels()
    }

    func fetchChannels() {
        guard let currentUserProfile = AppDefault.loadObject(type: Profile.self, key: .userProfile) else {
            print("Error: Unable to load user profile")
            return
        }

        isLoading = true
        let currentUserID = currentUserProfile.id
        let ref = Database.database().reference().child("channels")
        
        let ownerQuery = ref.queryOrdered(byChild: "ownerID").queryEqual(toValue: currentUserID)
        let requestQuery = ref.queryOrdered(byChild: "requestID").queryEqual(toValue: currentUserID)

        let dispatchGroup = DispatchGroup()
        var newChannels: [Channel] = []

        // Fetch channels where ownerID matches current user ID
        dispatchGroup.enter()
        ownerQuery.observeSingleEvent(of: .value) { snapshot in
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
            dispatchGroup.leave()
        }

        // Fetch channels where requestID matches current user ID
        dispatchGroup.enter()
        requestQuery.observeSingleEvent(of: .value) { snapshot in
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
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            // Removing duplicates if any
            self.channels = Array(Set(newChannels))
            self.isLoading = false
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
    
    func createChatChannel(productID: String, ownerID: String, requestID: String, ownerImageURL: String, requestImageURL: String, ownerName: String, requestName: String) {
        guard !productID.isEmpty,
              !ownerID.isEmpty,
              !requestID.isEmpty,
              !ownerImageURL.isEmpty,
              !requestImageURL.isEmpty,
              !ownerName.isEmpty,
              !requestName.isEmpty else {
            print("Error: All fields must be filled")
            return
        }
        
        let channelID = UUID().uuidString
        
        let newChannel: [String: Any] = [
            "id": channelID,
            "productID": productID,
            "ownerID": ownerID,
            "requestID": requestID,
            "ownerImageURL": ownerImageURL,
            "requestImageURL": requestImageURL,
            "ownerName": ownerName,
            "requestName": requestName,
            "timestamp": Date().timeIntervalSince1970
        ]
        
        let ref = Database.database().reference().child("channels").child(channelID)
        ref.setValue(newChannel) { error, _ in
            if let error = error {
                print("Error creating channel: \(error.localizedDescription)")
            } else {
                print("Channel created successfully!")
            }
        }
    }
}
