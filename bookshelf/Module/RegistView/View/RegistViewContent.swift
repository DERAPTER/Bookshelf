//
//  RegistViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 18.05.2026.
//

import SwiftUI

struct RegistViewContent: View {
    @State private var nameField = ""
    var btnAction: (String) -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Text("Добро пожаловать")
                    .font(type: .black, size: 22)
                    .foregroundStyle(.white)
                
                Spacer()
                
                BaseTextView(placeholder: "Ваше Имя", text: $nameField)
                
                Spacer()
                
                OrangeButton(title: "Далее") {
                    btnAction(nameField)
                }
            }.padding(.horizontal, 30)
        }
        .background(.bgMain)
    }
}

