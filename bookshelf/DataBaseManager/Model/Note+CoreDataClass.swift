//
//  Note+CoreDataClass.swift
//  bookshelf
//
//  Created by Егор Халиков on 11.06.2026.
//
//

public import Foundation
public import CoreData

public typealias NoteCoreDataClassSet = NSSet

@objc(Note)
public class Note: NSManagedObject {

}

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String?
    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var book: Book?

}

extension Note : Identifiable {
    func deleteNote() {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
