//
//  AddBookView.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import UIKit
import SwiftUI

protocol AddBookViewProtocol: BaseViewProtocol {
    func goToListView(books: [BookModelItem])
}

class AddBookView: UIViewController, AddBookViewProtocol {
    typealias PresenterType = AddBookPresenterProtocol
    var presenter: PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = AddBookViewContent { [weak self] direction in
            guard let self = self else { return }
            
            switch direction {
            case .forward(let book):
                if book.count > 2 {
                    self.presenter?.searchBook(by: book)
                }
            case .back:
                self.navigationController?.popViewController(animated: true)
            }
        }
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
    func goToListView(books: [BookModelItem]) {
        let vc = Builder.createListView(books: books)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
