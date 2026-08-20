//
//  AddBookViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import SwiftUI

struct AddBookViewContent: View {
    
    @State var bookName: String = ""
    
    var body: some View {
        VStack {
            NavHeader(title: "Добавить книгу") {
                
            }
            
            Spacer()
            
            BaseTextView(placeholder: "название книги", text: $bookName)
            
            Spacer()
            
            OrangeButton(title: "Далее") {
                 
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 30)
        .background(.bgMain)
    }
}

#Preview {
    AddBookViewContent()
}
