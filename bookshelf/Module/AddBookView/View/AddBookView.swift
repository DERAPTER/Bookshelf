//
//  AddBookView.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import UIKit

protocol AddBookViewProtocol: BaseViewProtocol {
    
}

class AddBookView: UIViewController, AddBookViewProtocol {
    typealias PresenterType = AddBookPresenterProtocol
    var presenter: PresenterType?
    
}
