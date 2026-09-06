//
//  BookListViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookListViewContent: View {
    
    let books: [BookModelItem]
    var completion: (BookModelItem?) -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            NavHeader(title: "Добавить книгу") {
                completion(nil)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Результаты поиска")
                        .foregroundStyle(.white)
                        .font(size: 14)
                        .padding(.horizontal, 21 )
                    
                    VStack(alignment: .leading, spacing: 23) {
                        ForEach(books, id: \.self) { book in
                            BookListItem(book: book) {
                                completion(book)
                            }
                        }
                        
                    }
                    
                }
                .padding(.top, 44)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 30)
        .background(.bgMain )
    }
}

struct BookListItem: View {
    var book: BookModelItem
    var completion: () -> Void
    
    var body: some View {
        Button {
            completion()
        } label: {
            HStack(alignment: .top, spacing: 13) {
                BookCover(coverId: book.cover_i?.description)
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

struct BookCover: View {
    var coverId: String?
    var body: some View {
        if let coverId, let url = URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg") {
            WebImage(url: url)
                .resizable()
                .scaledToFit()
                //.frame(width: 80, height: 120)
                .clipShape(.rect(cornerRadius: 3))
        } else {
            Image(.cover)
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 3))
        }
    }
}
