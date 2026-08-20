//
//  AddBookPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

protocol AddBookPresenterProtocol: AnyObject {
    
}

class AddBookPresenter: AddBookPresenterProtocol {
    weak var view: (any AddBookViewProtocol)?
    
    init(view: any AddBookViewProtocol) {
        self.view = view
    }
}
