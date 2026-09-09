//
//  AddDetailsView.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import UIKit
import SwiftUI
import Combine

protocol AddDetailsViewProtocol: BaseViewProtocol {
    
}

protocol AddDetailsViewDelegate {
    func saveBook()
    func back()
    func createText()
}

class AddDetailsViewModel: ObservableObject {
    @Published var bookDescription: String = ""
}

class AddDetailsView: UIViewController, AddDetailsViewProtocol, AddDetailsViewDelegate {
    typealias PresenterType = AddDetailsPresenterProtocol
    var presenter: PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewContent = AddDetailsViewContent(book: presenter?.book, delegate: self, viewModel: presenter!.viewModel)
        
        let content = UIHostingController(rootView: viewContent)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
    func saveBook() {
        print("save")
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func createText() {
        presenter?.createBookDescription()
    }
}
