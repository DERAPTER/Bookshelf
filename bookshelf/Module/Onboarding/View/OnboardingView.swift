//
//  OnboardingView.swift
//  bookshelf
//
//  Created by Егор Халиков on 10.06.2026.
//

import UIKit

protocol OnboardingViewProtocol: BaseViewProtocol {
    
}

class OnboardingView: UIViewController, OnboardingViewProtocol {
    typealias PresenterType = OnboardingViewPresenterProtocol
    var presenter: PresenterType?
    
    
}
