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
    var profile: Profile

    var body: some View {
        
        KFImage(URL(string: profile.profileImageURL)) .resizable()
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
    }
        
        
        
}

#Preview {
    ChatProfileView(profile: Profile(name: "Paola", surname: "Campanile", email: "paula@campanile.com", about: "Second-hand enthusiast 🌱 ", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png"))
}
