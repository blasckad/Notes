//
//  MemoItem+CoreDataClass.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 10.07.2023.
//
//

import Foundation
import CoreData


public class MemoItem: NSManagedObject {
    public func model() -> MemoItemModel? {
        let model = MemoItemModel(dueDate: dueDate, addDate: addDate, id: id, text: text, label: label)
        return model
    }
    
    public func setup(with model: MemoItemModel) {
        dueDate = model.dueDate
        addDate = model.addDate
        id = model.id
        label = model.label
        text = model.text
    }
}
