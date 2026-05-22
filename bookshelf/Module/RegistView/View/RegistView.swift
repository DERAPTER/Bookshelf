//
//  RegistView.swift
//  bookshelf
//
//  Created by Егор Халиков on 18.05.2026.
//

import UIKit
import SwiftUI

protocol RegistViewProtocol: BaseViewProtocol {
    
}


class RegistView: UIViewController, RegistViewProtocol {
    
    typealias PresenterType = RegistViewPresenterProtocol
    var presenter: PresenterType?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = RegistViewContent {
            print($0)
        }
        
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    

}
