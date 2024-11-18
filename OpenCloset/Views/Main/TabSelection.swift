//
//  TabSelection.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 17/11/24.
//
import SwiftUI
import Combine

class TabSelection: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var productID: String = ""
    @Published var ownerID: String = ""
    @Published var requestID: String = ""
    @Published var ownerImageURL: String = ""
    @Published var requestImageURL: String = ""
    @Published var ownerName: String = ""
    @Published var requestName: String = ""
}
