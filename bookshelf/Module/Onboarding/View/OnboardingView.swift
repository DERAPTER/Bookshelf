//
//  OnboardingView.swift
//  bookshelf
//
//  Created by Егор Халиков on 10.06.2026.
//

import UIKit
import SwiftUI

protocol OnboardingViewProtocol: BaseViewProtocol {
    
}

class OnboardingView: UIViewController, OnboardingViewProtocol {
    typealias PresenterType = OnboardingViewPresenterProtocol
    var presenter: PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = OnboardingViewContent(slides: presenter?.mockData ?? []) { [weak self] in
            guard let self = self else { return }
            presenter?.startApp()
        }
        
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
}
