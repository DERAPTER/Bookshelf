//
//  BookListView.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import UIKit

protocol BookListViewProtocol: BaseViewProtocol {
    
}

class BookListView: UIViewController, BookListViewProtocol {
    typealias PresenterType = BookListPresenterProtocol
    var presenter: PresenterType?
}
