//
//  BaseTextView.swift
//  bookshelf
//
//  Created by Егор Халиков on 05.08.2026.
//

import SwiftUI

struct BaseTextView: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .padding(.horizontal, 10)
            .background(.appDark)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 10))
    }
}
