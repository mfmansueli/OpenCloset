//
//  TestGrid.swift
//  OpenCloset
//
//  Created by Giorgia Granata on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var items = Array(1...20) // Initial items
    @State private var isLoading = false
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(items, id: \.self) { item in
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: 100)
                        .overlay(
                            Text("\(item)")
                                .foregroundColor(.white)
                                .font(.title)
                        )
                        .cornerRadius(10)
                }
                
                // Show loading indicator at the end of the list
                if isLoading {
                    ProgressView()
                        .padding()
                        .onAppear {
                            loadMoreData()
                        }
                }
            }
            .padding()
        }
        .onAppear {
            loadMoreData() // Load initial data
        }
    }
    
    func loadMoreData() {
        guard !isLoading else { return }
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let moreItems = Array(items.count + 1...items.count + 20)
            items.append(contentsOf: moreItems)
            isLoading = false
        }
    }
}
#Preview {
    ContentView() }
