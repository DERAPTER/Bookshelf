//
//  BookListPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

protocol BookListPresenterProtocol: AnyObject {
    
}

class BookListPresenter: BookListPresenterProtocol {
    weak var view: (any BookListViewProtocol)?
    
    init(view: any BookListViewProtocol) {
        self.view = view
    }
}
