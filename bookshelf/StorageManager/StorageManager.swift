//
//  StorageManager.swift
//  bookshelf
//
//  Created by Егор Халиков on 11.06.2026.
//

import Foundation

class StorageManager {
    
    private var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //MARK: Save cover
    ///`saveCover` функция для сохранения обложки
    ///`cover.jpeg` стандартное название обложки
    func saveCover(bookId: String, cover: Data) {
        var bookPath = path.appending(component: bookId)
        try? FileManager.default.createDirectory(at: bookPath, withIntermediateDirectories: true, attributes: nil)
        
        var coverPath = bookPath.appending(component: "cover.jpeg")
        
        do {
            try cover.write(to: coverPath)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// `getCover` функция для получения файла
    func getCover(bookId: String) -> Data? {
        var coverPath = path
            .appending(component: bookId)
            .appending(component: "cover.jpeg")
        
        do {
            let coverData = try Data(contentsOf: coverPath)
            return coverData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
