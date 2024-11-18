//
//  ChatDialogView.swift
//  OpenCloset
//
//  Created by Giorgio Durante on 12/11/24.
//

import SwiftUI

struct ChatDialogView: View {
    var profile: Profile = Profile(name: "Paola", surname: "Campanile", email: "paula@campanile.com", about: "Second-hand enthusiast 🌱 ", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png")
    
    var body: some View {

        VStack {
            
            ChatHeaderView()
            
            HStack {
                ChatProfileView(profile: profile)
                                
                
                ChatBubbleView(alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            
                HStack {
                   
                    Spacer()
                    
                    ChatBubbleView(message: "Te lo vieni a prendere un caffé? Poi andiamo a mangiare una pizza e parliamo di vestiti belli bellini.", alignment: .trailing)
                    
                  
                    VStack {
                        ChatProfileView(profile: profile)
                    }.frame(alignment: .bottom)
                        .padding(.bottom, -50)
            }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 16)
        }
        Spacer()
    }
}

#Preview {
    ChatDialogView()
}
