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
                
                TextField("Ваше имя", text: $nameField)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .padding(.horizontal, 10)
                    .background(.appDark)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 10))
                
                Spacer()
                
                OrangeButton(title: "Далее") {
                    btnAction(nameField)
                }
            }.padding(.horizontal, 30)
        }
        .background(.bgMain)
    }
}

