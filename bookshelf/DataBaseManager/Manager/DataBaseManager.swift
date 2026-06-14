//
//  DataBaseManager.swift
//  bookshelf
//
//  Created by Егор Халиков on 11.06.2026.
//

import Foundation
import CoreData

final class DataBaseManager {
    
    static let shared = DataBaseManager()
    private init() {}
    
    private let storageManager = StorageManager()
    
    var books: [Book] = []
    
    //MARK: Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "db")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


extension DataBaseManager {
    //MARK: Book
    /// `createBook` функция для сохранения одной книги
    
    func createBook(name: String, author: String, description: String, cover: Data) {
        let bookId = UUID().uuidString
        
        let book: Book = {
            $0.id = bookId
            $0.name = name
            $0.author = author
            $0.status = BookStatus.read.rawValue
            $0.coverURL = "cover.jpeg"
            $0.bookDescription = description
            $0.date = Date()
            return $0
        }(Book(context: persistentContainer.viewContext))
        
        saveContext()
        
        storageManager.saveCover(bookId: bookId, cover: cover)
    }
    
    /// `fetchBooks` метод для получения всех книг
    func fetchBooks() {
        let request = Book.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do {
            let books = try persistentContainer.viewContext.fetch(request)
            self.books = books
        } catch {
            print(error.localizedDescription)
        }
    }
}
