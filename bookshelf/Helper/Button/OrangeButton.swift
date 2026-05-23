//
//  OrangeButton.swift
//  bookshelf
//
//  Created by Егор Халиков on 23.05.2026.
//
 
import SwiftUI

struct OrangeButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .padding(.vertical, 19)
                .frame(maxWidth: .infinity)
                .background(.appOrange)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 10))
                .font(type: .bold, size: 14)
        })
    }
}
