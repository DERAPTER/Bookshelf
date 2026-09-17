//
//  CommentView.swift
//  bookshelf
//
//  Created by Егор Халиков on 15.08.2026.
//

import SwiftUI

struct CommentView: View {
    var date: String
    var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(date)
                .foregroundStyle(.white)
                .font(size: 12)
            Text(text)
                .foregroundStyle(.appGray)
                .font(size: 13)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .padding(.horizontal, 21)
        .background(.appDark)
        .clipShape(.rect(cornerRadius: 10))
    }
}
