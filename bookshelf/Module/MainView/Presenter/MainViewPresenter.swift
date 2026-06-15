//
//  MainViewPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 15.06.2026.
//

import Foundation

protocol MainViewPresenterProtocol: AnyObject {
    
}

class MainViewPresenter: MainViewPresenterProtocol {
    var view: (any MainViewProtocol)?
    
    init(view: any MainViewProtocol) {
        self.view = view
    }
}
