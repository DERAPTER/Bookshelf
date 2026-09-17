//
//  DetailsViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 08.08.2026.
//

import SwiftUI

struct DetailsViewContent: View {
    @State var bookNote: String = ""
    @State var offsetTop: CGFloat = 0
    @State var showTitle: Bool = false

    @State private var currentStatus: BookStatus
    @State private var showStatusDialog: Bool = false
    @State private var showDeleteAlert: Bool = false

    @ObservedObject var viewModel: DetailsViewModel

    var book: Book?
    var onBack: () -> Void
    var onStatusChange: (BookStatus) -> Void
    var onAddNote: (String) -> Void
    var onDeleteNote: (Note) -> Void
    var onDeleteBook: () -> Void

    var bookName: String {
        book?.name ?? ""
    }

    init(book: Book?,
         viewModel: DetailsViewModel,
         onBack: @escaping () -> Void = { },
         onStatusChange: @escaping (BookStatus) -> Void = { _ in },
         onAddNote: @escaping (String) -> Void = { _ in },
         onDeleteNote: @escaping (Note) -> Void = { _ in },
         onDeleteBook: @escaping () -> Void = { }) {
        self.book = book
        self.viewModel = viewModel
        self.onBack = onBack
        self.onStatusChange = onStatusChange
        self.onAddNote = onAddNote
        self.onDeleteNote = onDeleteNote
        self.onDeleteBook = onDeleteBook
        _currentStatus = State(
            initialValue: BookStatus(rawValue: book?.status ?? 0) ?? .read
        )
    }

    var body: some View {
        ZStack(alignment: .top) {
            header
            content
        }
        .background(.bgMain)
        .ignoresSafeArea()
        .alert("Удалить книгу?", isPresented: $showDeleteAlert) {
            Button("Удалить", role: .destructive) {
                onDeleteBook()
            }
            Button("Отмена", role: .cancel) { }
        } message: {
            Text("Книга и все её заметки будут удалены без возможности восстановления.")
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Button {
                onBack()
            } label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
            }

            Spacer()

            Text(showTitle ? bookName : "О книге")
                .font(size: 18)

            Spacer()

            Menu {
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Label("Удалить книгу", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .rotationEffect(.degrees(90))
                    .scaledToFill()
                    .frame(width: 20, height: 6)
                    .contentShape(Rectangle())
                    .padding(8)
            }
        }
        .foregroundStyle(.white)
        .zIndex(1)
        .padding(.top, 55)
        .padding(.horizontal, 30)
        .background(
            .bgMain.opacity(offsetTop < 0 ? (-offsetTop * 4.5 / 1000) : 0)
        )
    }

    // MARK: - Content

    private var content: some View {
        ScrollView {
            VStack(spacing: 29) {
                coverBlock
                descriptionAndNotes
            }
            .padding(.bottom, 30)
        }
    }

    // MARK: - Cover

    private var coverBlock: some View {
        ZStack(alignment: .top) {
            GeometryReader { proxy in
                let minY = proxy.frame(in: .global).minY
                if let book = book {
                    BookCoverForOverlay(book: book)
                        .scaledToFill()
                        .frame(maxWidth: proxy.size.width)
                        .frame(height: 420 + (minY > 0 ? minY : 0))
                        .clipped()
                        .overlay {
                            Color(.purple).opacity(0.5)
                        }
                        .offset(y: minY > 0 ? -minY : 0)
                        .onChange(of: minY) { oldValue, newValue in
                            offsetTop = newValue
                            withAnimation {
                                showTitle = newValue < -229
                            }
                        }
                }
            }
            .frame(height: 420)

            VStack(spacing: 15) {
                if let book = book {
                    CoverFromFileManager(book: book)

                    VStack(spacing: 2) {
                        Text(bookName)
                            .font(type: .bold, size: 20)
                        Text(book.author ?? "")
                            .font(type: .medium, size: 14)
                    }
                    .foregroundStyle(.white)
                }

                BookStatusButton(status: currentStatus) {
                    showStatusDialog = true
                }
                .confirmationDialog(
                    "Статус книги",
                    isPresented: $showStatusDialog,
                    titleVisibility: .visible
                ) {
                    ForEach(BookStatus.allCases, id: \.self) { status in
                        Button(status.title) {
                            guard status != currentStatus else { return }
                            withAnimation {
                                currentStatus = status
                            }
                            onStatusChange(status)
                        }
                    }
                    Button("Отмена", role: .cancel) { }
                }
            }
            .padding(.top, 90)
        }
    }

    // MARK: - Description + Notes

    private var descriptionAndNotes: some View {
        VStack(alignment: .leading, spacing: 36) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Описание")
                    .font(type: .black, size: 18)
                    .foregroundStyle(.white)
                Text(book?.bookDescription ?? "")
                    .font(size: 14)
                    .foregroundStyle(.appGray)
            }

            VStack(alignment: .leading, spacing: 14) {
                Text("Заметки по книге")
                    .font(type: .bold, size: 18)
                    .foregroundStyle(.white)

                VStack(alignment: .leading, spacing: 14) {
                    if viewModel.notes.isEmpty {
                        Text("Пока нет заметок")
                            .font(size: 13)
                            .foregroundStyle(.appGray)
                            .padding(.vertical, 8)
                    } else {
                        ForEach(viewModel.notes, id: \.objectID) { note in
                            NoteRow(note: note) {
                                withAnimation {
                                    onDeleteNote(note)
                                }
                            }
                        }
                    }
                }

                BaseTextView(
                    placeholder: "Добавить заметку",
                    text: $bookNote,
                    onSubmit: {
                        let trimmed = bookNote
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmed.isEmpty else { return }
                        onAddNote(trimmed)
                        bookNote = ""
                    }
                )
            }
        }
        .padding(.horizontal, 30)
    }
}

struct BookCoverForOverlay: View {
    var book: Book
    var body: some View {
        if let id = book.id,
           let cover = Image.from(folderName: id, fileName: "cover.jpeg") {
            cover
                .resizable()
        } else {
            Image(.cover)
                .resizable()
        }
    }
}
