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
    private var btnText: String
    
    init(status: BookStatus, action: @escaping () -> Void) {
        self.status = status
        self.action = action
        
        switch status {
        case .read:
            self.btnText = "Читаю"
        case .willRead:
            self.btnText = "Прочитать"
        case .didRead:
            self.btnText = "Прочитал"
        }
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(btnText)
                .padding(.vertical, 3)
                .padding(.horizontal, 18)
                .font(type: .bold, size: 14)
                .foregroundStyle(.white)
                .background(btnColor())
                .clipShape(Capsule())
        }
    }
    
    func btnColor() -> Color {
        switch status {
        case .read:
            return Color.statusFirst
        case .willRead:
            return Color.statusSecond
        case .didRead:
            return Color.statusThird
        }
    }
}
