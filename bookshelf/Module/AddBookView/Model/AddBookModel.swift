//
//  AddBookModel.swift
//  bookshelf
//
//  Created by Егор Халиков on 05.09.2026.
//

import Foundation

struct BookModel: Decodable, Hashable {
    let docs: [BookModelItem]
}

struct BookModelItem: Decodable, Hashable {
    let author_name: [String]?
    let cover_i: Int?
    let title: String?
}
