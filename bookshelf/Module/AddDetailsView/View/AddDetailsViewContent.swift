 //
//  AddDetailsViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import SwiftUI

struct AddDetailsViewContent: View {
    
    @State var bookName: String = ""
    @State var bookDescription: String = ""
    @State var isShowPlaceholder: Bool = true
    
    var body: some View {
        VStack {
            NavHeader(title: "Мартин Иден") {
                
            }
            
            VStack(spacing: 80) {
                Image(.cover)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130, height: 180)
                    .clipShape(.rect(cornerRadius: 3))
                    .overlay(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        Button {
                            
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.statusThird)
                                    .frame(width: 24, height: 24)
                                Image(systemName: "arrow.trianglehead.counterclockwise")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(.white)
                            }
                            .offset(x: 6, y: -6)
                        }
                    }
                
                VStack(spacing: 30) {
                    BaseTextView(placeholder: "Название", text: $bookName)
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $bookDescription)
                            .scrollContentBackground(.hidden)
                            .frame(height: 114)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .background(.appDark)
                            .font(size: 16)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    
                                } label: {
                                    Image(.ai)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 21, height: 21)
                                        .padding(.trailing, 16)
                                        .padding(.top, 16)
                                        .clipped()
                                }
                            }
                            .onChange(of: bookDescription) { oldValue, newValue in
                                if newValue.count > 0 {
                                    isShowPlaceholder = false
                                } else {
                                    isShowPlaceholder = true
                                }
                            }
                        
                        if isShowPlaceholder {
                            Text("Описание")
                                .font(size: 16)
                                .foregroundStyle(.appGray.opacity(0.7))
                                .offset(x: 20, y: 18)
                        }
                    }
                }
            }
            
            Spacer()
            
            OrangeButton(title: "Добавить") {
                
            }
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment(horizontal: .leading, vertical: .top))
        .background(.bgMain)
    }
}

#Preview {
    AddDetailsViewContent()
}
