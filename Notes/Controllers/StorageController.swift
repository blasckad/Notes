//
//  StorageController.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 11.07.2023.
//

import Foundation
import UIKit
import CoreData

public class StorageController {
    
    public init() {
    }
    
    let persistenceController = CoreDataPersistenceController.shared
    
    enum Constants {
        static let equalIdPredicate = "id == %@"
    }
    
    public func updateMemo(_ item: MemoItemModel) {
                                
        let itemFetchRequest = MemoItem.fetchRequest()
        itemFetchRequest.predicate = NSPredicate(format: Constants.equalIdPredicate, argumentArray: [item.id as Any])
        let itemObjects = try? persistenceController.context.fetch(itemFetchRequest)
        
        guard let itemObject = itemObjects?.first else { return }
        
        itemObject.setup(with: item)
        
        persistenceController.saveContext()
        
    }
    
    public func removeMemo(_ id: UUID?) {
        
        let fetchRequest = MemoItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: Constants.equalIdPredicate, argumentArray: [id as Any])
        guard let itemsToRemove = try? persistenceController.context.fetch(fetchRequest) else { return }
        
        for itemToRemove in itemsToRemove {
            persistenceController.context.delete(itemToRemove)
        }
        
        persistenceController.saveContext()
    }
    
    public func getMemos() -> [MemoItemModel] {
        
        let itemFetchRequest = MemoItem.fetchRequest()
        itemFetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \MemoItem.addDate, ascending: true)]
        guard let items = try? persistenceController.context.fetch(itemFetchRequest) else { return [] }
        
        return items.compactMap { $0.model() }
        
    }
    
    public func getMemoById(_ id: UUID?) -> [MemoItemModel] {
                    
        let itemFetchRequest = MemoItem.fetchRequest()
        itemFetchRequest.predicate = NSPredicate(format: Constants.equalIdPredicate, argumentArray: [id as Any])
        let item = try? persistenceController.context.fetch(itemFetchRequest)
        
        guard let item else { return [] }
        
        return item.compactMap { $0.model() }
    }
    
    public func insertMemo(_ item: MemoItemModel) {
        
        let persistenceController = CoreDataPersistenceController.shared
        
        let itemObject = MemoItem(context: persistenceController.context)
        itemObject.setup(with: item)
        
        persistenceController.saveContext()
        
    }
    
}
