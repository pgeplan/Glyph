//
//  DataModel.swift
//  ImageSpeak
//
//  Created by Anwar Baroudi on 6/21/15.
//  Copyright (c) 2015 Paige Plander. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class DataModel {
    var imageData: [UIImage]
    var labelData: [String]
    let speaker: AVSpeechSynthesizer
    var count: Int
    
    init() {
        imageData = []
        labelData = []
        speaker = AVSpeechSynthesizer()
        count = 0
    }
    
    func getImage(index: Int) -> UIImage {
        return imageData[index]
    }
    
    func getLabel(index: Int) -> String {
        return labelData[index]
    }
    
    func add(image: UIImage, label: String) {
        imageData.append(image)
        labelData.append(label)
        count += 1
    }
    
    func remove(index: Int) {
        imageData.removeAtIndex(index)
        labelData.removeAtIndex(index)
        count -= 1
    }
    
    func speakAtIndex(index: Int) {
        let speech = AVSpeechUtterance(string: labelData[index])
        speaker.speakUtterance(speech)
    }
    
}