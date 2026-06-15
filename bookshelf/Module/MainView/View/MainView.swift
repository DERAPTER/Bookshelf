//
//  MainView.swift
//  bookshelf
//
//  Created by Егор Халиков on 15.06.2026.
//

import UIKit

protocol MainViewProtocol: BaseViewProtocol {
    
}

class MainView: UIViewController, MainViewProtocol {
    typealias PresenterType = MainViewPresenterProtocol
    var presenter: PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
