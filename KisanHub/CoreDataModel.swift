//
//  CoreDataModel.swift
//  KisanHub
//
//  Created by Nikhil Modi on 9/28/18.
//  Copyright © 2018 Nikhil Modi. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class CoreDataModel {
    static let shared = CoreDataModel()
    let dataModelContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private init (){
        
    }
    func getObjectInstance(objectName:String)-> NSManagedObject?{
        return NSEntityDescription.insertNewObject(forEntityName: objectName, into: dataModelContext)
    }
    func savedataContext()  {
        self.dataModelContext.performAndWait {
            do{
                try self.dataModelContext.save()
            }
            catch{
                
            }
        }

    }
    func getFetchRequestController(region:String,filter:String?) -> NSFetchedResultsController<WeatherItem>{
        let fetchRequest = NSFetchRequest<WeatherItem>()
        let entityDescription = NSEntityDescription.entity(forEntityName: DatabaseConstant.weatherItem, in: self.dataModelContext)
        fetchRequest.entity = entityDescription
        if let filterNonNil = filter {
            let predicate = NSPredicate(format: "type=%@ AND regionCode=%@ ", filterNonNil,region)
            fetchRequest.predicate = predicate
        }
        else{
            let predicate = NSPredicate(format: "regionCode=%@", region)
            fetchRequest.predicate = predicate
        }

        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(WeatherItem.regionCode), ascending: true)]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataModelContext, sectionNameKeyPath: "type" , cacheName: nil)
    }
    func deleteValues(region:String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DatabaseConstant.weatherItem)
        let predicate = NSPredicate(format: "regionCode=%@", region)
        fetchRequest.predicate = predicate
        do {
            let items = try dataModelContext.fetch(fetchRequest) as! [NSManagedObject]
            for item in items {
                dataModelContext.delete(item)
            }
            try dataModelContext.save()

        }
        catch {

        }

        
    }

    
}
 extension NSPersistentContainer {
    public func destroyPersistentStore(at storeURL: URL) throws {
        let psc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.persistentStoreCoordinator
        try psc.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
    }
}
