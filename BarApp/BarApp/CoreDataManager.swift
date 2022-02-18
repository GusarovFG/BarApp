//
//  CoreDataManager.swift
//  BarApp
//
//  Created by Фаддей Гусаров on 16.12.2021.
//
import CoreData
import Foundation
import UIKit

class CoreDataManager {

    static var shared = CoreDataManager()

    private init(){}

    func save(date: String, screenShot: UIImage) {
        let schedule = Schedule(context: persistentContainer.viewContext)
        let jpegImage = screenShot.jpegData(compressionQuality: 1.0)
        schedule.date = date
        schedule.schedule = jpegImage

        saveContext()
    }

    func fetch() -> [Schedule] {
        let fetchRequest: NSFetchRequest<Schedule> = Schedule.fetchRequest()
        let objects = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        print(objects)
        return objects
    }

    func delete(index: Int) {
        let fetchRequest: NSFetchRequest<Schedule> = Schedule.fetchRequest()
        let objects = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        self.persistentContainer.viewContext.delete(objects[index])
        saveContext()
    }

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "BarApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
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
