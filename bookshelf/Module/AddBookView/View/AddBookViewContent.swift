//
//  AddBookViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import SwiftUI

enum NavDirection {
    case forward(String), back
}

struct AddBookViewContent: View {
    
    @State var bookName: String = ""
    var completion: (NavDirection) -> Void
    
    var body: some View {
        VStack {
            NavHeader(title: "Добавить книгу") {
                completion(.back)
            }
            
            Spacer()
            
            BaseTextView(placeholder: "название книги", text: $bookName)
            
            Spacer()
            
            OrangeButton(title: "Далее") {
                 completion(.forward(bookName))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 30)
        .background(.bgMain)
    }
}
