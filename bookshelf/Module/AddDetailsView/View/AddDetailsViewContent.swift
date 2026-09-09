 //
//  AddDetailsViewContent.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.08.2026.
//

import SwiftUI

enum DetailsPageState {
     case back, save
}

struct AddDetailsViewContent: View {
    
    @State var bookName: String = ""
    @State var isShowPlaceholder: Bool = true
    @ObservedObject var viewModel: AddDetailsViewModel
    var book: BookModelItem?
    @State var bookCover: UIImage = .cover
    var delegate: AddDetailsViewDelegate
    @State var isShowPicker = false
    @State var bookCoverType: ImageType
    
    init(book: BookModelItem? = nil, delegate: AddDetailsViewDelegate, viewModel: AddDetailsViewModel) {
        self.book = book
        self._bookName = .init(initialValue: book?.title ?? "")
        self.delegate = delegate
        self.viewModel = viewModel
        self.bookCoverType = .network(book?.cover_i?.description)
    }
    
    var body: some View {
        VStack {
            NavHeader(title: book?.title ?? "") {
                delegate.back()
            }
            
            VStack(spacing: 80) {
                
                BookCover2(image: bookCoverType)
                    .frame(width: 130, height: 180)
                    .clipped()
                    .overlay(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        Button {
                            isShowPicker.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.statusThird)
                                    .frame(width: 24, height: 24)
                                Image(systemName: "arrow.trianglehead.counterclockwise")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(.white)
                            }
                            .offset(x: 6, y: -6)
                        }
                        .sheet(isPresented: $isShowPicker) {
                            ImagePickerView(image: $bookCover)
                        }
                    }
                    .onChange(of: bookCover) { oldValue, newValue in
                        bookCoverType = .local(newValue)
                    }
                
                VStack(spacing: 30) {
                    BaseTextView(placeholder: "Название", text: $bookName)
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $viewModel.bookDescription)
                            .scrollContentBackground(.hidden)
                            .frame(height: 114)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .background(.appDark)
                            .font(size: 16)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    delegate.createText()
                                } label: {
                                    Image(.ai)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 21, height: 21)
                                        .padding(.trailing, 16)
                                        .padding(.top, 16)
                                        .clipped()
                                }
                            }
                            .onChange(of: viewModel.bookDescription) { oldValue, newValue in
                                if newValue.count > 0 {
                                    isShowPlaceholder = false
                                } else {
                                    isShowPlaceholder = true
                                }
                            }
                        
                        if isShowPlaceholder {
                            Text("Описание")
                                .font(size: 16)
                                .foregroundStyle(.appGray.opacity(0.7))
                                .offset(x: 20, y: 18)
                        }
                    }
                }
            }
            
            Spacer()
            
            OrangeButton(title: "Добавить") {
                delegate.saveBook()
            }
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment(horizontal: .leading, vertical: .top))
        .background(.bgMain)
    }
}

