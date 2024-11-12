//
//  EmptyStateView.swift
//  OpenCloset
//
//  Created by Giorgio Durante on 11/11/24.
//

import SwiftUI

struct EmptyStateView: View {
    
    var imageName: String = "envelope"
    var subtext: String = "Your chat is empty!\n Start swapping!"
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .foregroundColor(Color("PinkStrong"))
            
            Text (subtext)
                .foregroundStyle(Color("PinkStrong"))
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
}

#Preview {
    EmptyStateView(imageName: "envelope")
}
