//
//  Image.ext.swift
//  bookshelf
//
//  Created by Егор Халиков on 12.09.2026.
//

import SwiftUI

extension Image {
    static func from(folderName: String, fileName: String) -> Image? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileURL = directory.appendingPathComponent(folderName).appendingPathComponent(fileName)
        guard fileManager.fileExists(atPath: fileURL.path),
              let uiImage = UIImage(contentsOfFile: fileURL.path) else {
            return nil
        }
        
        return Image(uiImage: uiImage)
    }
}
