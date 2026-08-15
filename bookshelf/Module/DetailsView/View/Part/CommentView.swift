//
//  CommentView.swift
//  bookshelf
//
//  Created by Егор Халиков on 15.08.2026.
//

import SwiftUI

struct CommentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("13.01.25")
                .foregroundStyle(.white)
                .font(size: 12)
            Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .foregroundStyle(.appGray)
                .font(size: 13)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 21)
        .background(.appDark)
    }
}
