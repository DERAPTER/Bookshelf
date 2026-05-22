//
//  CustomFont.swift
//  bookshelf
//
//  Created by Егор Халиков on 21.05.2026.
//

import SwiftUI

struct CustomFont: ViewModifier {
    var font: FontType
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content.font(.custom(font.rawValue, size: size))
    }
}
