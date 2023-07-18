//
//  MemoItem+CoreDataProperties.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 10.07.2023.
//
//

import Foundation
import CoreData


extension MemoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoItem> {
        return NSFetchRequest<MemoItem>(entityName: "Memos")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var label: String?
    @NSManaged public var text: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var addDate: Date?

}

extension MemoItem : Identifiable {

}
