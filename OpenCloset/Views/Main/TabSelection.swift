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
}
