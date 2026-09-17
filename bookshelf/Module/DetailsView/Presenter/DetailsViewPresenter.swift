//
//  DetailsViewPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 08.08.2026.
//

import Foundation

protocol DetailsViewPresenterProtocol: AnyObject {
    var book: Book { get }
    var notes: [Note] { get }
    func changeStatus(to status: BookStatus)
    func addNote(text: String)
    func deleteNote(_ note: Note)
    func deleteBook()
}

class DetailsViewPresenter: DetailsViewPresenterProtocol {
    weak var view: (any DetailsViewProtocol)?
    var book: Book
    private let dbManager = DataBaseManager.shared

    var notes: [Note] {
        dbManager.notes(for: book)
    }

    init(view: any DetailsViewProtocol, book: Book) {
        self.view = view
        self.book = book
    }

    func changeStatus(to status: BookStatus) {
        dbManager.updateBookStatus(book: book, status: status)
    }

    func addNote(text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        dbManager.addNote(book: book, noteText: trimmed)
    }

    func deleteNote(_ note: Note) {
        dbManager.deleteNote(note)
    }

    func deleteBook() {
        dbManager.deleteBook(book)
    }
}
