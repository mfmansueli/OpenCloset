//
//  ChatProfileView.swift
//  OpenCloset
//
//  Created by Giorgio Durante on 12/11/24.
//

import SwiftUI
import Kingfisher
struct ChatProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel = ProfileViewModel()
    var senderID: String = ""
    var senderImageURL: String = ""
    
    var body: some View {
        KFImage(URL(string: senderImageURL))
            .resizable()
            .fade(duration: 0.25)
            .placeholder{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.accent))
            }
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ChatProfileView(senderID: "", senderImageURL: "")
}
