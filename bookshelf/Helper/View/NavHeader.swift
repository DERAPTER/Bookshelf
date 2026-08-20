//
//  NavHeader.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import SwiftUI

struct NavHeader: View {
    var title: String
    var action: () -> Void
    var body: some View {
        HStack {
            /// `btn` back
            Button {
                action()
            } label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Text(title)
                .font(type: .black, size: 22)
                .foregroundStyle(.white)
            
            Spacer()
            
            Rectangle()
                .opacity(0)
                .frame(width: 20, height: 20)
        }
    }
}

