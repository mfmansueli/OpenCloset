//
//  ChatHeaderView.swift
//  OpenCloset
//
//  Created by Giorgio Durante on 12/11/24.
//

import SwiftUI

struct ChatHeaderView: View {
    var body: some View {
        VStack {
            
            Divider()
                .frame(height: 1)
                .background(Color("LinePink"))
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                    
                    Image("ItemCloset")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                
                VStack(alignment: .leading) {
                    Text("Handmade Hat")
                        .font(.title2)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        
                    
                    
                    Text("One size, handmade, made of wool. Used 1 or 2 times.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.all)
            
            
            Divider()
                .frame(height: 1)
                .background(Color("LinePink"))
        }
    }
}

#Preview {
    ChatHeaderView()
}
