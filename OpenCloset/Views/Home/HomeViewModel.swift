//
//  Untitled.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import Foundation
import FirebaseFirestore
import SwiftUI
import CoreLocation

class HomeViewModel: ObservableObject {
    @ObservedObject var locationManager = LocationManager()
    var items: [Profile] = []
    @Published var filteredItems: [Profile] = []
    
    @Published var errorMessage: String?
    @Published var page = 1 { didSet { fetchProfiles(page: page) } }
    
    private var timer: Timer?
    @Published var searchText = "" {
        didSet {
            timer?.invalidate()
            let value = searchText
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.filterList(text: value)
            })
        }
    }
    
    init() {
        fetchProfiles(page: page)
    }
    
    func fetchProfiles(page: Int) {
        let collection: Query = Firestore.firestore().collection("Profiles").limit(toLast: page * 100).order(by: "name")
        var list: [Profile] = []
        collection.getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                self?.errorMessage = error.localizedDescription
            } else {
                for document in snapshot!.documents {
                    do {
                        var profile = try document.data(as: Profile.self)
                        profile.id = document.documentID
                        list.append(profile)
                    } catch(let error) {
                        print("Error decoding profile: \(error)")
                    }
                }
                
                if page == 1 {
                    self?.items = list
                    self?.filterList(text: self?.searchText ?? "")
                }
            }
        }
    }
    
    func filterList(text: String) {
        if text.isEmpty {
            filteredItems = items
            return
        }
        filteredItems = items.filter { $0.name.lowercased().contains(text.lowercased()) }
    }
    
    var userLatitude: Double {
        return locationManager.location?.coordinate.latitude ?? 0.0
    }
    
    var userLongitude: Double {
        return locationManager.location?.coordinate.longitude ?? 0.0
    }
}
