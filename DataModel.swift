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
    var folderDict: [String: (images: [UIImage], labels: [String])]
    let speaker: AVSpeechSynthesizer
    var count: Int
    let independent: Bool
    
    init(isNewEmptyDataModel: Bool) {
        independent = isNewEmptyDataModel
        folderDict = [String: (images: [UIImage], labels: [String])]()
        speaker = AVSpeechSynthesizer()
        count = 0
        imageData = []
        labelData = []
        if independent == false {
            iconStorage = fetchFromCoreData()
//            loadImages()
            fillDict()
            count = iconStorage.count
//            removeAll()
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
    
    func fillDict() {
        for item in iconStorage {
            let temp = item.valueForKey("folder") as! String
            print("++++++++")
            print(temp)
            print("+++++++")
            if folderDict[temp] == nil {
                folderDict[temp] = (images: [UIImage](), labels: [String]())
            }
            folderDict[temp]!.labels.append(item.valueForKey("iconLabel") as! String)
            folderDict[temp]!.images.append(UIImage(data: (item.valueForKey("iconImage") as? NSData)!)!)
            
        }
        print("fillDict")
        print(folderDict)
        print("fillDict")
    }

    
//    func loadImages() {
//        for item in iconStorage {
//            imageData.append(UIImage(data: (item.valueForKey("iconImage") as? NSData)!)!)
//        }
//    }
    
    func getImage(index: Int, folder: String) -> UIImage {
        if independent {
            return imageData[index]
        }
//        let image = UIImage(data: (iconStorage[index].valueForKey("iconImage") as? NSData)!)
//        if image == nil {
//            print("error with getImage")
//            return image!
//        } else {
//            return image!
//        }
//        print(index)
//        print(folder)
//        print(folderDict[folder])
        return folderDict[folder]!.images[index]
    }
    
    func getLabel(index: Int, folder: String) -> String {
        if independent {
            if labelData.isEmpty {
                return "nil"
            }
            return labelData[index]
        }
        
        return folderDict[folder]!.labels[index]
        
    }
    
    func add(image: UIImage, label: String, folder: String) {
        if independent {
            imageData.append(image)
            labelData.append(label)
        } else {
            addToIconStorage(image, label: label, folder: folder)
            
            if folderDict[folder] == nil {
                folderDict[folder] = (images: [UIImage](), labels: [String]())
            }
            folderDict[folder]!.images.append(image)
            folderDict[folder]!.labels.append(label)
            print(folder)
            print("\n")
            print(folderDict)
            print("\n")
            print(folderDict[folder])
            print("\n")
            print(folderDict[folder]!)
        }
        count += 1
    }
    
    func addToIconStorage(image: UIImage, label: String, folder: String) {
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
        icon.setValue(folder, forKey: "folder")

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
    
    func removeAll() {
        var i = 0
        while i < count {
            remove(i)
            i += 1
        }
    }
    
    func speakAtIndex(index: Int, folder: String) {
        let speech = AVSpeechUtterance(string: getLabel(index, folder: folder))
        speech.rate = 0.5
        speaker.speakUtterance(speech)
    }
    
}