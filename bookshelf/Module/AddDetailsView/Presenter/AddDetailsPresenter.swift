//
//  AddDetailsPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

protocol AddDetailsPresenterProtocol: AnyObject {
    var book: BookModelItem { get }
    func createBookDescription()
}

class AddDetailsPresenter: AddDetailsPresenterProtocol {
    var book: BookModelItem
    private let manager = NetworkManager()
    weak var view: (any AddDetailsViewProtocol)?
    
    init(view: any AddDetailsViewProtocol, book: BookModelItem ) {
        self.view = view
        self.book = book
    }
    
    func createBookDescription() {
        manager.sendRequest(bookName: book.title ?? "")
    }
}
