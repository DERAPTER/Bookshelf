//
//  BookCover.swift
//  bookshelf
//
//  Created by Егор Халиков on 07.09.2026.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookCover: View {
    var coverId: String?
    var body: some View {
        if let coverId, let url = URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg") {
            WebImage(url: url)
                .resizable()
                .scaledToFit()
                //.frame(width: 80, height: 120)
                .clipShape(.rect(cornerRadius: 3))
        } else {
            Image(.cover)
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 3))
        }
    }
}

enum ImageType {
    case local(UIImage)
    case network(String?)
}

struct BookCover2: View {
    var image: ImageType
    var body: some View {
        switch image {
        case .local(let uIImage):
            Image(uiImage: uIImage)
                .resizable()
                .scaledToFill()
                .clipShape(.rect(cornerRadius: 3))
        case .network(let uRL):
            if let uRL, let url = URL(string: "https://covers.openlibrary.org/b/id/\(uRL)-M.jpg") {
                WebImage(url: url)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 3))
            } else {
                Image(.cover)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 3))
            }
        }
    }
}
