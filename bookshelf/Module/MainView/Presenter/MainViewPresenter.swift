//
//  MainViewPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 15.06.2026.
//

import Foundation

protocol MainViewPresenterProtocol: AnyObject {
    var name: String { get }
}

class MainViewPresenter: MainViewPresenterProtocol {
    var name: String
    var view: (any MainViewProtocol)?
    
    init(view: any MainViewProtocol) {
        self.view = view
        self.name = UserDefaults.standard.string(forKey: "name") ?? ""
    }
}
