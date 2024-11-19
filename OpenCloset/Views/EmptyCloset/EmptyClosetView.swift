//
//  ClosetTest.swift
//  OpenCloset
//
//  Created by Giorgio Durante on 11/11/24.
//

import SwiftUI

struct EmptyClosetView: View {
    var body: some View {
        EmptyStateView(imageName: "hanger", subtext: "Your OpenCloset is empty" )
    }
}

#Preview {
    EmptyClosetView()
}
