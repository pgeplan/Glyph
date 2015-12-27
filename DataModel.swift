//
//  DataModel.swift
//  Glyph
//
//  Created by Anwar Baroudi on 6/21/15.
//  Copyright (c) 2015 Paige Plander. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreData

class DataModel {
    var iconStorage = [NSManagedObject]()
    var imageData: [UIImage]
    var labelData: [String]
    let speaker: AVSpeechSynthesizer
    var count: Int
    let independent: Bool
    
    init(isNewEmptyDataModel: Bool) {
        independent = isNewEmptyDataModel
        speaker = AVSpeechSynthesizer()
        count = 0
        if independent {
            imageData = []
            labelData = []
        } else {
            imageData = []
            labelData = []
            iconStorage = fetchFromCoreData()
            count = iconStorage.count
        }
    }
    
    func fetchFromCoreData() -> [NSManagedObject] {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "IconData")
        var fetchResults = [NSManagedObject]?()
        do {
            fetchResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]

        } catch let error {
            print("Could not cache the response \(error)")
            
        }
        let results = fetchResults as [NSManagedObject]?
        return results!
        
        
    }
    
    func isEmpty() -> Bool {
        return iconStorage.count == 0 && imageData.count == 0
    }
    
    func getImage(index: Int) -> UIImage {
        if independent {
            return imageData[index]
        }
        let image = UIImage(data: (iconStorage[index].valueForKey("iconImage") as? NSData)!)
        if image == nil {
            print("error with getImage")
            return image!
        } else {
            return image!
        }
    }
    
    func getLabel(index: Int) -> String {
        if independent {
            if labelData.isEmpty {
                return "nil"
            }
            return labelData[index]
        }
        
        return (iconStorage[index].valueForKey("iconLabel") as? String)!
        
    }
    
    func add(image: UIImage, label: String) {
        if independent {
            imageData.append(image)
            labelData.append(label)
        } else {
            addToIconStorage(image, label: label)
        }
        count += 1
    }
    
    func addToIconStorage(image: UIImage, label: String) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("IconData",
            inManagedObjectContext:
            managedContext)
        let icon = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        let imageInBinaryData = UIImagePNGRepresentation(image)
        icon.setValue(imageInBinaryData, forKey: "iconImage")
        icon.setValue(label, forKey: "iconLabel")

        do {
            try managedContext.save()
        }
        catch let error {
            print("Could not cache the response \(error)")
        }
        
        
    
        iconStorage.append(icon)
    }
    
    func remove(index: Int) {
        if independent {
            imageData.removeAtIndex(index)
            labelData.removeAtIndex(index)
        } else {
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            context.deleteObject(iconStorage[index] as NSManagedObject)
            iconStorage.removeAtIndex(index)
            
            do {
                try context.save()
            }
            catch let error {
                print("Could not cache the response \(error)")
            }
    
        }
        count -= 1
    }
    
    func speakAtIndex(index: Int) {
        let speech = AVSpeechUtterance(string: getLabel(index))
        speech.rate = 0.1
        speaker.speakUtterance(speech)
    }
    
}