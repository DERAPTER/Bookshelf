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
    
    /// `updateBookStatus` меняет статус книги и сохраняет контекст
    func updateBookStatus(book: Book, status: BookStatus) {
        book.status = status.rawValue
        saveContext()
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
    
    /// `deleteBook` удаляет книгу, её заметки (каскадом) и файл обложки
    func deleteBook(_ book: Book) {
        if let id = book.id {
            storageManager.deleteBookFolder(bookId: id)
        }

        persistentContainer.viewContext.delete(book)
        saveContext()

        if let index = books.firstIndex(where: { $0.objectID == book.objectID }) {
            books.remove(at: index)
        }
    }
}

extension DataBaseManager {
    //MARK: Note
    /// `addNote` добавляет заметку к книге и сохраняет контекст
    func addNote(book: Book, noteText: String) {
        let note = Note(context: persistentContainer.viewContext)
        note.id = UUID().uuidString
        note.date = Date()
        note.text = noteText
        note.book = book
        saveContext()
    }

    /// `deleteNote` удаляет заметку и сохраняет контекст
    func deleteNote(_ note: Note) {
        persistentContainer.viewContext.delete(note)
        saveContext()
    }

    /// `notes` для книги, отсортированные по убыванию даты
    func notes(for book: Book) -> [Note] {
        let set = book.notes as? Set<Note> ?? []
        return set.sorted { ($0.date ?? .distantPast) > ($1.date ?? .distantPast) }
    }
}
