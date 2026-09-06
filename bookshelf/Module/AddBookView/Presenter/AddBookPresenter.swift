//
//  AddBookPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import Foundation

protocol AddBookPresenterProtocol: AnyObject {
    func searchBook(by title: String)
}

class AddBookPresenter: AddBookPresenterProtocol {
    weak var view: (any AddBookViewProtocol)?
    private let manager = BookNetworkManager()
    
    init(view: any AddBookViewProtocol) {
        self.view = view
    }
    
    func searchBook(by title: String) {
        manager.searchBookRequest(q: title) { [weak self] books in
            guard let self = self else { return }
            
            switch books {
            case .success(let success):
                DispatchQueue.main.async {
                    self.view?.goToListView(books: success)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
