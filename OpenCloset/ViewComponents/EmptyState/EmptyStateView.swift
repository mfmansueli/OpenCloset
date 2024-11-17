//
//  EmptyStateView.swift
//  OpenCloset
//
//  Created by Giorgio Durante on 11/11/24.
//

import SwiftUI

struct EmptyStateView: View {
    
    var imageName: String = ""
    var subtext: String = ""
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .foregroundColor(Color(.accent))
            
            Text(subtext)
                .foregroundStyle(Color(.accent))
                .font(.system(size: 20))
                .padding(.top, 8)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
}

#Preview {
    EmptyStateView(imageName: "hanger", subtext: "Your Open Closet is empty")
}
