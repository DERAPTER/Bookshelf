//
//  View.ext.swift
//  bookshelf
//
//  Created by Егор Халиков on 21.05.2026.
//

import SwiftUI

extension View {
    func font(type: FontType = .regular, size: CGFloat = 14) -> some View {
        modifier(CustomFont(font: type, size: size))
    }
}
