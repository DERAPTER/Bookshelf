//
//  DetailsView.swift
//  bookshelf
//
//  Created by Егор Халиков on 08.08.2026.
//

import UIKit

protocol DetailsViewProtocol: BaseViewProtocol {
    
}

class DetailsView: UIViewController, DetailsViewProtocol {
    
    typealias PresenterType = DetailsViewPresenterProtocol
    var presenter:PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
