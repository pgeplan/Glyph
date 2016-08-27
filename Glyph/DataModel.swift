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

/// DataModel for the icon tiles
class DataModel: CustomStringConvertible {
    
    /// TODO: Redo this file its awful i did a little
    
    /// The array of icon tile stored in core data
    var iconStorage = [NSManagedObject]()
    
    /// The array of tiles created by the user
    var tiles: [Tile]
    
    /// Maps folder names to each folder's corresponding tiles
    var folderDictionary: [String: [Tile]!]
    
    /// Speech Synthesizer used to speak out the tile name when a tile is selected
    let speaker: AVSpeechSynthesizer
    
    /// Why? Anwar pls
    var count: Int
    
    /// No clue what this is cmon Anwar
    let independent: Bool
    
    /// Makes printing pretty
    var description: String {
        var dataModelToString = "DataModel("
        for folder in folderDictionary {
            // add the folder name
            dataModelToString += "\(folder.0) : ["
            
            // print out the tiles in the folder dictionary
            for tile in folder.1 {
                dataModelToString += "\(tile), "
            }
            // remove the last comma
            dataModelToString = String(dataModelToString.characters.dropLast(2))
            dataModelToString += "]"
        }
        return dataModelToString
    }
    
    
    init(isNewEmptyDataModel: Bool) {
        independent = isNewEmptyDataModel
        folderDictionary = NSDictionary() as! [String : [Tile]]
        speaker = AVSpeechSynthesizer()
        count = 0
        tiles = []
        if independent == false {
            iconStorage = fetchFromCoreData()
            fillTilesDictionaryFromIconStorage()
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
        return iconStorage.count == 0 && tiles.count == 0
    }
    
    /// Anwar what the hell is this pls no i made it better but still cmon
    func fillTilesDictionaryFromIconStorage() {
        for item in iconStorage {
            let foldername = item.valueForKey("folder") as! String
            if folderDictionary[foldername] == nil {
                folderDictionary[foldername] = []
            }
            if let iconTitle = item.valueForKey("iconLabel") as? String,
              let iconImageData = item.valueForKey("iconImage") as? NSData,
              let iconImage = UIImage(data: iconImageData) {
                
                let newTile = Tile(tileName: iconTitle, tileImage: iconImage, folderName: foldername)
                folderDictionary[foldername]!.append(newTile)
            }
        }
    }
    
    /**
     Returns the number of tiles within the given folder
     
     - parameter folder: The folder we want to check the number of tiles within
     
     - returns: The number of tiles within the folder
     */
    func countForFolder(folder: String) -> Int {
        return (folderDictionary[folder] != nil) ? folderDictionary[folder]!.count : 0
    }
    
    /**
     Get the tile's image at the given index within the given folder
     
     - parameter index:  The index of the tile within the given folder
     - parameter folder: The folder that the tile is in
     
     - returns: The image of the the tile within the given folder at the given index
     */
    func getImage(index: Int, folder: String) -> UIImage {
        if independent {
            return tiles[index].tileImage
        }
        if let tileImage = folderDictionary[folder]?[index].tileImage {
            return tileImage
        }
        else {
            assert(folderDictionary[folder]?[index].tileImage != nil, "Each tile should have an image")
            return UIImage()
        }
    }
    
    func getLabel(index: Int, folder: String) -> String {
        if independent {
            if tiles.isEmpty {
                assert(!tiles.isEmpty, "The tiles array should not be empty")
                return "nil"
            }
            return tiles[index].tileName
        }
        if let tileName = folderDictionary[folder]?[index].tileName {
            return tileName
        }
        else {
            assert(folderDictionary[folder]?[index].tileName != nil, "Each tile should have a name")
            return String()
        }
    }
    
    func addTile(tile: Tile) {
        if independent {
            tiles.append(tile)
        }
        else {
            addToTileStorage(tile)
            if folderDictionary[tile.folderName] == nil {
                folderDictionary[tile.folderName] = [Tile()]
            }
            folderDictionary[tile.folderName]!.append(tile)
        }
        count += 1
    }
    
    /**
     Saves the newly added tile to Core Data
     
     - parameter tile: The tile the user added
     */
    private func addToTileStorage(tile: Tile) {
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("IconData",
                                                        inManagedObjectContext:
            managedContext)
        let icon = NSManagedObject(entity: entity!,
                                   insertIntoManagedObjectContext:managedContext)
        let imageInBinaryData = UIImagePNGRepresentation(tile.tileImage)
        icon.setValue(imageInBinaryData, forKey: "iconImage")
        icon.setValue(tile.tileName, forKey: "iconLabel")
        icon.setValue(tile.folderName, forKey: "folder")
        
        do {
            try managedContext.save()
        }
        catch let error {
            print("Could not cache the response \(error)")
        }
        iconStorage.append(icon)
    }
    
    /**
     Finds the index of the icon tile within the given folder
     
     - parameter folderName: The name of the folder that the tile is in
     - parameter tile:       The tile that we want to find the index of
     
     - returns: The tile's index within the given folder's `tiles` array
     */
    func findIndex(folderName: String, tile: Tile) -> Int {
        var index = 0
        for element in iconStorage {
            let label = element.valueForKey("iconLabel") as! String
            let folder = element.valueForKey("folder") as! String
            if (label == tile.tileName) && (folderName == folder){
                return index
            }
            else {
                index = index + 1
            }
        }
        return index
    }
    
    /**
     Remove the tile from the given folder
     
     - parameter folderName: The name of the folder we want to remove the tile from
     - parameter tile:       The tile that the user wants to remove
     */
    func remove(folderName: String, tile: Tile) {
        let index = findIndex(folderName, tile: tile)
        if independent {
            tiles.removeAtIndex(index)
        }
        else {
            // var folderDict: [String: (images: [UIImage], labels: [String])]
            if var tiles = folderDictionary[folderName] {
                let tileIndex = tiles.indexOf(tile)
                // fix this mess later
                tiles.removeAtIndex(tileIndex ?? 0)
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
            
        }
        count -= 1
    }
    
    /**
     Remove the folder with the given folder name and the tiles within it
     
     - parameter folderName: The name of the folder that we want to remove
     */
    func removeFolder(folderName: String) {
        if let folder = folderDictionary[folderName] {
            for tile in folder {
                remove(folderName, tile: tile)
            }
        }
    }
    
    /**
     Speak out the label for the tile at the given index within the given folder
     
     - parameter index:  The index within the folder for the tile that was tapped
     - parameter folder: The name of the folder that the user is currently in
     */
    func speakAtIndex(index: Int, folder: String) {
        let speech = AVSpeechUtterance(string: getLabel(index, folder: folder))
        speech.rate = 0.5
        speaker.speakUtterance(speech)
    }
    
}