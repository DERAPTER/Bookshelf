//
//  OnboardingViewData.swift
//  bookshelf
//
//  Created by Егор Халиков on 10.06.2026.
//

import Foundation

struct OnboardingViewData: Identifiable {
    var id: UUID = UUID()
    
    var image: String
    var description: String
    
    static var mockData: [OnboardingViewData] {
        [
            OnboardingViewData(image: "book1", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit"),
            OnboardingViewData(image: "book2", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo"),
            OnboardingViewData(image: "brain", description: "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo")
        ]
    }
}
