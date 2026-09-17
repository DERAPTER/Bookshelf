//
//  MainView.swift
//  bookshelf
//
//  Created by Егор Халиков on 15.06.2026.
//

import UIKit
import SwiftUI
import Combine

protocol MainViewProtocol: BaseViewProtocol {
    
}

class MainViewModel: ObservableObject {
    @Published var readingBooks: [Book] = []
    @Published var unreadBooks: [Book] = []
    @Published var willReadBooks: [Book] = []
}

class MainView: UIViewController, MainViewProtocol {
    typealias PresenterType = MainViewPresenterProtocol
    var presenter: PresenterType?
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = MainViewContent(
            viewModel: viewModel,
            name: presenter?.name ?? "") { book in
            self.navToVc(book: book)
        }
        
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.fetch()
        viewModel.readingBooks = self.presenter?.readingBooks ?? []
        viewModel.unreadBooks = self.presenter?.unreadBooks ?? []
        viewModel.willReadBooks = self.presenter?.willReadBooks ?? []
    }
    
    private func navToVc(book: Book?) {
        if let book {
            let detailsVC = Builder.createDetailsView(book: book)
            navigationController?.pushViewController(detailsVC, animated: true )
        } else {
            let vc = Builder.createAddView()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
