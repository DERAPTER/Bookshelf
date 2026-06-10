//
//  RegistViewPresenter.swift
//  bookshelf
//
//  Created by Егор Халиков on 18.05.2026.
//

import Foundation


protocol RegistViewPresenterProtocol: AnyObject {
    func checkName(name: String)
}


class RegistViewPresenter: RegistViewPresenterProtocol {
    
    weak var view: (any RegistViewProtocol)?
    
    init(view: any RegistViewProtocol) {
        self.view = view
    }
    
    func checkName(name: String) {
        if name.count >= 2 {
            //UserDefaults.standard.set(name, forKey: "name")
            NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: WindowCase.onboarding])
        }
        else {
            // TODO: вывод сообщения
            print("Error")
        }
    }
    
}
