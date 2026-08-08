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
                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .global).minY
                        ZStack {
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
                    }
                    .frame(height: 400)
                }
            }
        }
        .background(.bgMain)
    }
}

#Preview {
    DetailsViewContent()
}
