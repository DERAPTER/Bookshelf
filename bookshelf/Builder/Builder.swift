//
//  Builder.swift
//  bookshelf
//
//  Created by Егор Халиков on 18.05.2026.
//

import UIKit

protocol BaseViewProtocol: AnyObject {
    associatedtype PresenterType
    var presenter: PresenterType? { get set }
}


class Builder {
    
    static private func createView<View: UIViewController & BaseViewProtocol>(viewType: View.Type, presenter: (View) -> View.PresenterType) -> UIViewController {
        let view = View()
        let presenter = presenter(view)
        view.presenter = presenter
        return view
    }
    
    
    static func createRegistView() -> UIViewController {
        return self.createView(viewType: RegistView.self) { view in
            RegistViewPresenter(view: view)
        }
    }
    
}
