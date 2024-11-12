//
//  SearchBarView.swift
//  OpenCloset
//
//  Created by Giorgio Durante on 11/11/24.
//

import SwiftUI

struct SearchBarView: View {
    var body: some View {
       
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 380, height: 50)
                    .shadow(radius: 10)
            
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("PinkStrong"))
                    .bold()
                    
                
                
                Text("Search")
                    .foregroundColor(Color("PinkStrong"))
                    .bold()

                Spacer()
                
                Image(systemName: "microphone.fill")
                    .foregroundColor(Color("PinkStrong"))
                    .bold()
            }
            .padding(.all)
        }
        .padding(.all)
        
        Spacer()
        
        
        
    }
}

#Preview {
    SearchBarView()
}
