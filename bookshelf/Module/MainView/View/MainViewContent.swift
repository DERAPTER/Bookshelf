//
//  MainViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 04.08.2026.
//

import SwiftUI

struct MainViewContent: View {
    
    @State var searchField = ""
    var name: String
    
    //var books: [Book]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                
                //MARK: HEADER
                VStack(alignment: .leading, spacing: 25) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Добрый день")
                                .font(size: 14)
                            Text(name)
                                .font(type: .black, size: 16)
                        }
                        .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "book.closed")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 14, height: 14)
                                Text("добавить")
                                    .font(size: 14)
                            }
                            .padding(.vertical, 7)
                            .padding(.horizontal, 14)
                            .background(.appOrange)
                            .clipShape(Capsule())
                            .foregroundStyle(.white)
                        }
                        
                    }
                    
                    BaseTextView(placeholder: "Поиск", text: $searchField)
                        .font()
                }
                .padding(.horizontal, 30)
            
                //MARK: READ
                VStack(alignment: .leading, spacing: 18) {
                    
                    Text("Читаю")
                        .font(type: .bold, size: 22)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 30)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            Button {
                                
                            } label: {
                                Image(.cover)
                                    .resizable()
                                    .frame(width: 143, height: 212)
                                    .clipShape(.rect(cornerRadius: 5))
                            }
                            
                            Button {
                                
                            } label: {
                                Image(.cover)
                                    .resizable()
                                    .frame(width: 143, height: 212)
                                    .clipShape(.rect(cornerRadius: 5))
                            }
                            
                            Button {
                                
                            } label: {
                                Image(.cover)
                                    .resizable()
                                    .frame(width: 143, height: 212)
                                    .clipShape(.rect(cornerRadius: 5))
                            }
                        }
                        .padding(.horizontal, 30)
                    }
                }
                
            }
        }
        //.ignoresSafeArea()
        .background(Color.bgMain)
    }
}


#Preview {
    MainViewContent(name: "Egor")
}
