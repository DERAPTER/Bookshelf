//
//  NoteRow.swift
//  bookshelf
//
//  Created by Егор Халиков on 16.09.2026.
//

import SwiftUI

struct NoteRow: View {
    var note: Note
    var onDelete: () -> Void

    @State private var offsetX: CGFloat = 0
    private let revealWidth: CGFloat = 80

    private var dateText: String {
        guard let date = note.date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: date)
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            Button {
                onDelete()
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 20)
            }

            CommentView(date: dateText, text: note.text ?? "")
                .offset(x: -offsetX)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let dx = value.translation.width
                            if dx < 0 {
                                offsetX = min(abs(dx), revealWidth)
                            } else {
                                offsetX = max(0, offsetX - dx)
                            }
                        }
                        .onEnded { value in
                            let shouldOpen = value.translation.width < -revealWidth / 2
                                || offsetX > revealWidth / 2
                            withAnimation(.easeOut(duration: 0.2)) {
                                offsetX = shouldOpen ? revealWidth : 0
                            }
                        }
                )
        }
    }
}
