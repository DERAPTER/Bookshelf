//
//  DetailsView.swift
//  bookshelf
//
//  Created by Егор Халиков on 08.08.2026.
//

import UIKit
import SwiftUI
import Combine

protocol DetailsViewProtocol: BaseViewProtocol {

}

class DetailsViewModel: ObservableObject {
    @Published var notes: [Note] = []
}

class DetailsView: UIViewController, DetailsViewProtocol {

    typealias PresenterType = DetailsViewPresenterProtocol
    var presenter: PresenterType?
    var viewModel = DetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.notes = presenter?.notes ?? []

        let contentView = DetailsViewContent(
            book: presenter?.book,
            viewModel: viewModel,
            onStatusChange: { [weak self] status in
                self?.presenter?.changeStatus(to: status)
            },
            onAddNote: { [weak self] text in
                guard let self else { return }
                self.presenter?.addNote(text: text)
                self.viewModel.notes = self.presenter?.notes ?? []
            },
            onDeleteNote: { [weak self] note in
                guard let self else { return }
                self.presenter?.deleteNote(note)
                self.viewModel.notes = self.presenter?.notes ?? []
            },
            onDeleteBook: { [weak self] in
                guard let self else { return }
                self.presenter?.deleteBook()
                self.navigationController?.popToRootViewController(animated: true)
            }
        )

        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
}
