//
//  CoreDataPersistenceController.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 10.07.2023.
//

import Foundation
import CoreData
import UIKit

public class CoreDataPersistenceController {
    
    private init() {
    }
    
    public static let shared = CoreDataPersistenceController()
        
    public let context = (UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()).persistentContainer.viewContext
    
    public func saveContext() {
        (UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()).saveContext()
    }
}
