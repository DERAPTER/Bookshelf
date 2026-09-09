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
