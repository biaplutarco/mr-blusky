//
//  DBManager.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 20/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

import Foundation
import CoreData

class DBManager {
    
    static let sharedInstance = DBManager()
    
    private init() {}
    
    let appDelegate = AppDelegate.shared.delegate as! AppDelegate
    let persistentContainer = (AppDelegate.shared.delegate as! AppDelegate).persistentContainer
    let context = (AppDelegate.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Saving
    func saveCity(name: String, id: Int16) {
        let city = City(context: persistentContainer.viewContext)
        city.id = id
        city.name = name
        
        appDelegate.saveContext()
    }
    
    func saveSunStyle(path: String, image: UIImage) {
        let style = SunStyle(context: persistentContainer.viewContext)
        style.imagePath = path
        
        FileManager.sharedInstance.saveImage(path, image: image)
        
        appDelegate.saveContext()
    }
    
    // MARK: - Get
    func getSunStyle() -> UIImage {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SunStyle")
        do {
            let styles = try context.fetch(request) as! [SunStyle]
            return FileManager.sharedInstance.getImageFrom(path: (styles.first?.imagePath)!)!
        } catch {
            fatalError()
        }
    }
    
    
    func getCity(name: String) -> City {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        do {
            let cities = try context.fetch(request) as! [City]
            let citiesFiltered = cities.filter { (city) -> Bool in
                city.name == name
            }
            return citiesFiltered[0] //colocar um alert
        } catch {
            fatalError()
        }
    }
    
    func getCityNames() -> [String] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        do {
            let cities = try context.fetch(request) as! [City]
            var names = [String]()
            cities.forEach { (city) in
                names.append(city.name!)
            }
            
            return names
        } catch {
            fatalError()
        }
    }
    
    func getCityID(name: String) -> (Int16) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        do {
            let cities = try context.fetch(request) as! [City]
            let citiesFiltered = cities.filter { (city) -> Bool in
                city.name == name
            }
            let cityID = citiesFiltered.first!.id
            
            return cityID
        } catch {
            fatalError()
        }
    }
    
    
    
    // MARK: - Delete
    func deleteCity(name: String) {
        let city = getCity(name: name)
        do {
            context.delete(city)
            try context.save()
        } catch {
            print("ih nao deu")
        }
    }
    
    func deleteSunStyle(path: String) {
        deleteAllFrom(entity: "SunStyle")
        FileManager.sharedInstance.removeFromFileManagerWith(path: path)
    }
    
    func deleteAllFrom(entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}
