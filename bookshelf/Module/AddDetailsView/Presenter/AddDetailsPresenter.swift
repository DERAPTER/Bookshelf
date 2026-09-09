//
//  AddDetailsPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import Foundation

protocol AddDetailsPresenterProtocol: AnyObject {
    var book: BookModelItem { get }
    var viewModel: AddDetailsViewModel { get set }
    func createBookDescription()
}

class AddDetailsPresenter: AddDetailsPresenterProtocol {
    var book: BookModelItem
    private let manager = NetworkManager()
    weak var view: (any AddDetailsViewProtocol)?
    var viewModel = AddDetailsViewModel()
    init(view: any AddDetailsViewProtocol, book: BookModelItem ) {
        self.view = view
        self.book = book
    }
    
    func createBookDescription() {
        manager.sendRequest(bookName: book.title ?? "") { [weak self] description in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.viewModel.bookDescription = description
            }
        }
    }
}
