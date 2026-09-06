//
//  BookItem.swift
//  bookshelf
//
//  Created by Егор Халиков on 04.09.2026.
//

import SwiftUI

struct BookItem: View {
    //var book: Book
    
    var body: some View {
        HStack(spacing: 13) {
            Image(.cover)
                .resizable()
                .frame(width: 64, height: 94)
                .clipShape(.rect(cornerRadius: 3))
            VStack(alignment: .leading, spacing: 9) {
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Война и Мир")
                        .font(type: .bold, size: 14)
                    Text("Лев Толстой")
                        .font(type: .medium, size: 12)
                        .foregroundStyle(.appGray)
                }
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                    .font(type: .bold, size: 14)
            }
            .foregroundStyle(.white)
        }
    }
}

