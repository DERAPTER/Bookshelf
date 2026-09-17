//
//  MainViewPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 15.06.2026.
//

import Foundation

protocol MainViewPresenterProtocol: AnyObject {
    var name: String { get }
    var books: [Book] { get set }
    
    var readingBooks: [Book] { get }
    var unreadBooks: [Book] { get }
    var willReadBooks: [Book] { get }
    
    func fetch()
}

class MainViewPresenter: MainViewPresenterProtocol {
    var name: String
    var view: (any MainViewProtocol)?
    
    var readingBooks: [Book] = []
    var unreadBooks: [Book] = []
    var willReadBooks: [Book] = []
    
    var books: [Book] = []
    private var bookService = DataBaseManager.shared
    
    init(view: any MainViewProtocol) {
        self.view = view
        self.name = UserDefaults.standard.string(forKey: "name") ?? ""
        fetch()
    }
    
    func setBooks(newValue: [Book]) {
        readingBooks = newValue.filter { $0.status == BookStatus.read.rawValue }
        unreadBooks = newValue.filter { $0.status == BookStatus.didRead.rawValue }
        willReadBooks = newValue.filter { $0.status == BookStatus.willRead.rawValue }
    }
    
    func fetch() {
        bookService.fetchBooks()
        setBooks(newValue: bookService.books)
    }
}
