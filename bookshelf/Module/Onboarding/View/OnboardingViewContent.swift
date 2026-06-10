//
//  OnboardingViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 10.06.2026.
//

import SwiftUI

struct OnboardingViewContent: View {
    var slides: [OnboardingViewData]
    var completion: () -> Void
    
    @State var selected: Int = 0 {
        willSet {
            if newValue == slides.count - 1 {
                btnText = "Начать пользоваться"
            }
        }
    }
    @State var btnText: String = "Далее"
    
    var body: some View {
        VStack {
            
            Text("Добро пожаловать")
                .font(type: .black, size: 22)
                .foregroundStyle(.white)
            
            Spacer()
            
            VStack {
                TabView(selection: $selected) {
                    
                    ForEach(0..<slides.count, id: \.self) { slide in
                        SlideItem(tag: slide, item: slides[slide])
                            .padding(.horizontal, 30)
                    }
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                HStack {
                    ForEach(0..<slides.count, id: \.self) { slide in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundStyle(slide == selected ? .orange : .white)
                            .onTapGesture {
                                withAnimation {
                                    selected = slide
                                }
                            }
                    }
                }
                
            }
            .frame(height: 400)
            
            Spacer()
            
            VStack {
                OrangeButton(title: btnText) {
                    if selected < slides.count - 1 {
                        withAnimation {
                            selected += 1
                        }
                    } else {
                        completion()
                    }
                }
            }
            .padding(.horizontal, 30)
                
        }
        .background(.bgMain)
    }
    
}


struct SlideItem: View {
    var tag: Int
    var item: OnboardingViewData
    
    var body: some View {
        VStack {
            Image(item.image)
                .resizable()
                .scaledToFill()
                .frame(width: 220, height: 220)
                .clipped()
            Text(item.description)
                .font(size: 16)
                .foregroundStyle(.white)
        }
        .tag(tag)
    }
}

