//
//  BookStatus.swift
//  bookshelf
//
//  Created by Егор Халиков on 14.06.2026.
//

import Foundation

enum BookStatus: Int16, CaseIterable {
    case read
    case willRead
    case didRead

    var title: String {
        switch self {
        case .read:     return "Читаю"
        case .willRead: return "Прочитать"
        case .didRead:  return "Прочитал"
        }
    }
}
