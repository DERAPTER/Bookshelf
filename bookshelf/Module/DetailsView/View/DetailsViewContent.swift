//
//  DetailsViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 08.08.2026.
//

import SwiftUI

struct DetailsViewContent: View {
    @State var bookNote: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                /// `btn` back
                Button {
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                }
                
                Spacer()
                
                Text("О книге")
                    .font(size: 18)
                
                Spacer()
                
                /// `btn` menu
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .rotationEffect(.degrees(90))
                        .scaledToFill()
                        .frame(width: 20, height: 6)
                }
            }
            .foregroundStyle(.white)
            .zIndex(1)
            .padding(.top, 15)
            .padding(.horizontal, 30)
            
            ScrollView {
                VStack(spacing: 29) {
                    ZStack(alignment: .top) {
                        GeometryReader { proxy in
                            let minY = proxy.frame(in: .global).minY
                            Image(.cover)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: proxy.size.width)
                                .frame(height: 400 + (minY > 0 ? minY : 0))
                                .clipped()
                                .overlay {
                                    Color(.purple).opacity(0.5)
                                }
                                .offset(y: -minY)
                        }
                        .frame(height: 400)
                        
                        VStack(spacing: 15) {
                            Image(.cover)
                            
                            VStack(spacing: 2) {
                                Text("Война и Мир")
                                    .font(type: .bold, size: 20)
                                Text("Лев Толстой")
                                    .font(type: .medium, size: 14)
                            }
                            .foregroundStyle(.white)
                            
                            BookStatusButton(status: .didRead) {
                                
                            }
                        }
                        .padding(.top, 55)
                    }
                    
                    VStack(alignment: .leading, spacing: 36) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Описание")
                                .font(type: .black, size: 18)
                                .foregroundStyle(.white)
                            Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo")
                                .font(size: 14)
                                .foregroundStyle(.appGray)
                        }
                        
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Заметки по книге")
                                .font(type: .bold, size: 18)
                                .foregroundStyle(.white)
                            
                            VStack(alignment: .leading, spacing: 14) {
                                
                                CommentView()
                                CommentView()
                                
                            }
                            
                            BaseTextView(placeholder: "Добавить заметку", text: $bookNote)
                        }
                    }
                    .padding(.horizontal, 30)
                    .background(.bgMain)
                }
                .padding(.bottom, 30)
            }
        }
        .background(.bgMain)
    }
}

#Preview {
    DetailsViewContent()
}
