//
//  DataManager.swift
//  Saper
//
//  Created by  Rezuan on 15/01/2019.
//  Copyright © 2019  Rezuan. All rights reserved.
//

import Foundation
import CoreData

struct DataManager {
    static let shared = DataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, err) in
            if let err = err {
                fatalError("loading error: \(err)")
            }
        })
        return container
    }()
    
    
    func createNote(name: String, time: Int) {
        let context = persistentContainer.viewContext
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context)
        
        note.setValue(name, forKey: "name")
        note.setValue(time, forKey: "time")
        
        do {
            try context.save()
        } catch let err {
            print(err)
        }
    }
    
    func fetchNotes() -> [Note] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        
        do {
            let notes = try context.fetch(fetchRequest)
            return notes
        } catch let err {
            print(err)
            return []
        }
    }
    
   
    
}
