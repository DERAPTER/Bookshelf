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
    func saveBook(imageType: ImageType, bookDescription: String, bookName: String, authorName: String)
    func back()
    func createText()
    func goToMain()
}

class AddDetailsViewModel: ObservableObject {
    @Published var bookDescription: String = ""
    @Published var isAddError: Bool = false
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
    
    func saveBook(imageType: ImageType, bookDescription: String, bookName: String, authorName: String) {
        presenter?.createBook(imageType: imageType, bookDescription: bookDescription, bookName: bookName, authorName: authorName) { result in
            switch result {
            case .success(let success):
                if success {
                    self.goToMain()
                }
            case .failure(let failure):
                print("error: \(failure)")
            }
        }
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func createText() {
        presenter?.createBookDescription()
    }
    
    func goToMain() {
        print("start animation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
