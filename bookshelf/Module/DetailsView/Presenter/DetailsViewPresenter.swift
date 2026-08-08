//
//  DetailsViewPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 08.08.2026.
//

import Foundation

protocol DetailsViewPresenterProtocol: AnyObject {
    
}

class DetailsViewPresenter: DetailsViewPresenterProtocol {
    weak var view: (any DetailsViewProtocol)?
    
    init(view: any DetailsViewProtocol) {
        self.view = view
    }
}
