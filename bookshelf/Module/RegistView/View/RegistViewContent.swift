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
                
                Button(action: {
                    btnAction(nameField)
                }, label: {
                    Text("Далее")
                        .padding(.vertical, 19)
                        .frame(maxWidth: .infinity)
                        .background(.appOrange)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 10))
                        .font(type: .bold, size: 14)
                })
            }.padding(.horizontal, 30)
        }
        .background(.bgMain)
    }
}


//#Preview {
//    RegistViewContent()
//}
