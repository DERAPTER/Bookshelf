//
//  BookListPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import Foundation

protocol BookListPresenterProtocol: AnyObject {
    var bookList: [BookModelItem]? { get }
}

class BookListPresenter: BookListPresenterProtocol {
    var bookList: [BookModelItem]?
    
    weak var view: (any BookListViewProtocol)?
    
    init(view: any BookListViewProtocol, bookList: [BookModelItem]?) {
        self.view = view
        self.bookList = bookList
    }
}
