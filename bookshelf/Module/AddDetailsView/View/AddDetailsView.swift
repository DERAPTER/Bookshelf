//
//  AddDetailsView.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import UIKit
import SwiftUI

protocol AddDetailsViewProtocol: BaseViewProtocol {
    
}

class AddDetailsView: UIViewController, AddDetailsViewProtocol {
    typealias PresenterType = AddDetailsPresenterProtocol
    var presenter: PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewContent = AddDetailsViewContent()
        
        let content = UIHostingController(rootView: viewContent)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
}
