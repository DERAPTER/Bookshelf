//
//  MainViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 04.08.2026.
//

import SwiftUI

enum SelectedCategory {
    case willRead
    case didRead
}

struct MainViewContent: View {
    
    @State var searchField = ""
    @State private var selectedCategory: SelectedCategory = .willRead
    var name: String
    
    //var books: [Book]
    
    var body: some View {
        
        ZStack(alignment: .top) {
            //MARK: HEADER
            VStack(alignment: .leading) {
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
            }
            .padding(.horizontal, 30)
            .zIndex(9)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    //MARK: READ
                    VStack(alignment: .leading, spacing: 25) {
                        
                        BaseTextView(placeholder: "Поиск", text: $searchField)
                            .font()
                            .padding(.horizontal, 30)
                        
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
                    
                    //MARK: Will/Did Read
                    VStack(alignment: .leading) {
                        HStack(alignment: .bottom, spacing: 26) {
                            Button {
                                selectedCategory = .willRead
                            } label: {
                                createButtonText(text: "Прочитать", category: .willRead)
                            }
                            
                            Button {
                                selectedCategory = .didRead
                            } label: {
                                createButtonText(text: "Прочитал", category: .didRead)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if selectedCategory == .willRead {
                            VStack(spacing: 20) {
                                BookItem()
                                BookItem()
                            }
                        } else {
                            VStack(spacing: 20) {
                                BookItem()
                                BookItem()
                                BookItem()
                                BookItem()
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }
            }
            //.ignoresSafeArea()
            .padding(.top, 80)
            .background(Color.bgMain)
        }
    }
    
    @ViewBuilder
    func createButtonText(text: String, category: SelectedCategory) -> some View {
        let condition = selectedCategory == category
        
        Text(text)
            .font(type: condition ? .bold : .regular, size: condition ? 22 : 20)
            .foregroundStyle(condition ? .white : .appGray)
    }
    
}


#Preview {
    MainViewContent(name: "Egor")
}

struct BookItem: View {
    //var book: Book
    
    var body: some View {
        HStack(spacing: 13) {
            Image(.cover)
                .resizable()
                .frame(width: 64, height: 94)
                .clipShape(.rect(cornerRadius: 3))
            VStack(alignment: .leading, spacing: 9) {
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Война и Мир")
                        .font(type: .bold, size: 14)
                    Text("Лев Толстой")
                        .font(type: .medium, size: 12)
                        .foregroundStyle(.appGray)
                }
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                    .font(type: .bold, size: 14)
            }
            .foregroundStyle(.white)
        }
    }
}
