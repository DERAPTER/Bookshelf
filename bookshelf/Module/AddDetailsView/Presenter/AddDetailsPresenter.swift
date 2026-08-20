//
//  AddDetailsPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

protocol AddDetailsPresenterProtocol: AnyObject {
    
}

class AddDetailsPresenter: AddDetailsPresenterProtocol {
    weak var view: (any AddDetailsViewProtocol)?
    
    init(view: any AddDetailsViewProtocol) {
        self.view = view
    }
}
