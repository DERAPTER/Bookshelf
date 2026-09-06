//
//  DetailsView.swift
//  bookshelf
//
//  Created by Егор Халиков on 08.08.2026.
//

import UIKit
import SwiftUI

protocol DetailsViewProtocol: BaseViewProtocol {
    
}

class DetailsView: UIViewController, DetailsViewProtocol {
    
    typealias PresenterType = DetailsViewPresenterProtocol
    var presenter:PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = DetailsViewContent()
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
}
