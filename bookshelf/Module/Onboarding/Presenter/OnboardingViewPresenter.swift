//
//  OnboardingViewPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 10.06.2026.
//

protocol OnboardingViewPresenterProtocol: AnyObject {
    
}

class OnboardingViewPresenter: OnboardingViewPresenterProtocol {
    weak var view: OnboardingViewProtocol?
    
    init(view: any OnboardingViewProtocol) {
        self.view = view
    }
}
