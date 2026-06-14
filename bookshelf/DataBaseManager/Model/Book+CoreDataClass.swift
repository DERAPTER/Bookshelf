//
//  Book+CoreDataClass.swift
//  bookshelf
//
//  Created by Егор Халиков on 14.06.2026.
//
//

public import Foundation
public import CoreData

public typealias BookCoreDataClassSet = NSSet

@objc(Book)
public class Book: NSManagedObject {

}

public typealias BookCoreDataPropertiesSet = NSSet

extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var id: String?
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var author: String?
    @NSManaged public var status: Int16
    @NSManaged public var bookDescription: String?
    @NSManaged public var coverURL: String?
    @NSManaged public var notes: NSSet?

}

extension Book : Identifiable {
    func deleteBook() {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
