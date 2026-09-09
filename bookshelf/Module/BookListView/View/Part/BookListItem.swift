//
//  BookListItem.swift
//  bookshelf
//
//  Created by Егор Халиков on 07.09.2026.
//

import SwiftUI

struct BookListItem: View {
    var book: BookModelItem
    var completion: () -> Void
    
    var body: some View {
        Button {
            completion()
        } label: {
            HStack(alignment: .top, spacing: 13) {
                BookCover2(image: .network(book.cover_i?.description))
                    .frame(width: 80, height: 120)
                
                VStack(alignment: .leading) {
                    Text(book.title ?? "-")
                        .foregroundStyle(.white)
                        .font(type: .black, size: 16)
                    Text(book.author_name?.first  ?? "-")
                        .foregroundStyle(.appGray)
                        .font(type: .medium , size: 14)
                }
                .padding(.top, 10)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white)
                    .padding(.top, 10)
            }
        }
    }
}

