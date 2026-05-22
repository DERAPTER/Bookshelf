//
//  RegistViewPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 18.05.2026.
//

import Foundation


protocol RegistViewPresenterProtocol: AnyObject {
    
}


class RegistViewPresenter: RegistViewPresenterProtocol {
    weak var view: (any RegistViewProtocol)?
    
    init(view: any RegistViewProtocol) {
        self.view = view
    }
    
}
