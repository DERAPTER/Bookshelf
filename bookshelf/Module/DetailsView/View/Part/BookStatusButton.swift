//
//  BookStatusButton.swift
//  bookshelf
//
//  Created by Егор Халиков on 10.08.2026.
//

import SwiftUI

struct BookStatusButton: View {
    var status: BookStatus
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(status.title)
                .padding(.vertical, 3)
                .padding(.horizontal, 18)
                .font(type: .bold, size: 14)
                .foregroundStyle(.white)
                .background(btnColor())
                .clipShape(Capsule())
        }
    }

    private func btnColor() -> Color {
        switch status {
        case .read:     return Color.statusFirst
        case .willRead: return Color.statusSecond
        case .didRead:  return Color.statusThird
        }
    }
}
