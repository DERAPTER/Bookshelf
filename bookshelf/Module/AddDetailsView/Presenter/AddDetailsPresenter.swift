//
//  AddDetailsPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import Foundation
import UIKit

protocol AddDetailsPresenterProtocol: AnyObject {
    var book: BookModelItem { get }
    var viewModel: AddDetailsViewModel { get set }
    func createBookDescription()
    func createBook(imageType: ImageType, bookDescription: String, bookName: String, authorName: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class AddDetailsPresenter: AddDetailsPresenterProtocol {
    var book: BookModelItem
    private let manager = NetworkManager()
    private var dbManager = DataBaseManager.shared
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
    
    func createBook(imageType: ImageType, bookDescription: String, bookName: String, authorName: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        switch imageType {
        case .local(let uIImage):
            let imageData = uIImage.jpegData(compressionQuality: 1)!
            dbManager.createBook(name: bookName, author: authorName, description: bookDescription, cover: imageData)
            completion(.success(true))
            
        case .network(let urlString):
            if let urlString, let url = URL(string: "https://covers.openlibrary.org/b/id/\(urlString)-M.jpg") {
                manager.loadCover(url: url) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let imageData):
                        self.dbManager.createBook(name: bookName, author: authorName, description: bookDescription, cover: imageData)
                        completion(.success(true))
                    case .failure(let failure):
                        let _ = failure as? SaveError
                        DispatchQueue.main.async {
                            self.viewModel.isAddError = true
                        }
                    }
                    
                }
            } else {
                completion(.failure(SaveError.missingData))
            }
        }
    }
    
}
