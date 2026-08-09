//
//  DetailsViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 08.08.2026.
//

import SwiftUI

struct DetailsViewContent: View {
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
                VStack {
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
                }
            }
        }
        .background(.bgMain)
    }
}

#Preview {
    DetailsViewContent()
}

struct BookStatusButton: View {
    var status: BookStatus
    var action: () -> Void
    private var btnText: String
    
    init(status: BookStatus, action: @escaping () -> Void) {
        self.status = status
        self.action = action
        
        switch status {
        case .read:
            self.btnText = "Читаю"
        case .willRead:
            self.btnText = "Прочитать"
        case .didRead:
            self.btnText = "Прочитал"
        }
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(btnText)
                .padding(.vertical, 3)
                .padding(.horizontal, 18)
                .font(type: .bold, size: 14)
                .foregroundStyle(.white)
                .background(btnColor())
                .clipShape(Capsule())
        }
    }
    
    func btnColor() -> Color {
        switch status {
        case .read:
            return Color.statusFirst
        case .willRead:
            return Color.statusSecond
        case .didRead:
            return Color.statusThird
        }
    }
}
