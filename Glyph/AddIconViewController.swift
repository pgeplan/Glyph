//
//  SettingsModalViewController.swift
//  Created by Paige Plander on 4/21/16.
//  Copyright (c) 2016 Paige Plander. All rights reserved.
//

import UIKit
import Foundation

class AddIconViewController: UITableViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    var data = DataModel(isNewEmptyDataModel: false)
    
    // delete when we get folders working
    var folders: [String] = NSUserDefaults.standardUserDefaults().arrayForKey("folders") as? [String] ?? ["General"]
    
    @IBOutlet weak var previewTileView: UIView!
    
    @IBOutlet weak var folderTextField: UITextField!
    // Image View attribute
    @IBOutlet var imagePicker: UIImageView!
    
    var img: UIImage?
    
    @IBOutlet weak var addButton: UIButton!
    
    let picker = UIImagePickerController()
    
    // Text Field for User to add Picture Label
    @IBOutlet var textField: UITextField!
    

    
    func returnImage() -> UIImage {
        return imagePicker.image!
    }
    
    func returnImageName() -> String? {
        if textField.text == "" {
            return nil
        }
        return textField.text
    }
    
    func returnFolderName() -> String {
        if let folderName = folderTextField.text {
            if folderName == "" {
                return "General"
            }
            else {
                return folderName
            }
        }
        return "General"
    }
    
    @IBAction func changePhoto(sender: UIButton) {
        let choosePhotoActionSheet = UIAlertController(title: nil, message: "Add Tile Image", preferredStyle: .ActionSheet)
        
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.takePhoto()
        })
        let chooseFromLibraryAction = UIAlertAction(title: "Choose from Library", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.chooseFromLibrary(sender)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        choosePhotoActionSheet.addAction(takePhotoAction)
        choosePhotoActionSheet.addAction(chooseFromLibraryAction)
        choosePhotoActionSheet.addAction(cancelAction)
        
        self.presentViewController(choosePhotoActionSheet, animated: true, completion: nil)
    }
    

    func takePhoto() {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.delegate = self
            picker.allowsEditing = false
            picker.sourceType = .Camera
            picker.cameraCaptureMode = .Photo
            presentViewController(picker, animated: true, completion: nil)
        }
        
        // If the device does not have a camera, throw an alert
        else {
            let alertVC = UIAlertController(title: "Camera Feature Not Available", message: "This device does not have a camera", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
            alertVC.addAction(okAction)
            presentViewController(alertVC, animated: true, completion: nil)
        }
    }
    
    func chooseFromLibrary(sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        picker.modalPresentationStyle = .Popover
        presentViewController(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.sourceView = sender
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        let folderPicker = UIPickerView()
        folderPicker.dataSource = self
        folderPicker.delegate = self
        folderTextField.attributedPlaceholder = NSAttributedString(string: "Choose Folder", attributes: [NSForegroundColorAttributeName : UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1)])

        addButton.layer.cornerRadius = 5
        previewTileView.layer.cornerRadius = 5
        folderTextField.inputView = folderPicker
    }
    
    @IBAction func resign() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func notifyUserOfError(popUpTitle: String, popUpMessage: String, popUpButtonLabel: String) -> Void {
        let alertController = UIAlertController(title: popUpTitle, message: popUpMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: popUpButtonLabel, style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // taken from http://stackoverflow.com/questions/27833075/swift-uilabel-programmatically-updates-after-uibutton-pressed
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        let pickedImage: UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        let sizeOfImageView:CGRect = imagePicker.frame
        imagePicker.frame = sizeOfImageView
        imagePicker.image = pickedImage
        img = imagePicker.image
        
    }
    
    
    // scale down the image size for a tile
    func scaleDownImage(image: UIImage) -> UIImage {
        let size = image.size
        let widthRatio  = 150/image.size.width
        let heightRatio = 150/image.size.height
        var newImageSize: CGSize
        if(widthRatio > heightRatio) {
            newImageSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        }
        else {
            newImageSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        let rect = CGRectMake(0, 0, 150, 150)
        UIGraphicsBeginImageContextWithOptions(newImageSize, false, 1.0)
        image.drawInRect(rect)
        let imageToReturn = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageToReturn
    }
    
    
    // Executes if the user wants to cancel (inside choose Photo)
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButton(sender: UIButton) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let basic = userDefaults.boolForKey("basicMode")
        //identifier doesn't matter here
        if shouldPerformSegueWithIdentifier("", sender: self) {
            if basic {
                performSegueWithIdentifier("addToBasic", sender: self)
            } else {
                performSegueWithIdentifier("addToMain", sender: self)
            }
        }
    }
    
    //MARK: Folder Picker delegate/dataSource methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.folders.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.folders[row];
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        folderTextField.text = self.folders[row];
        folderTextField.endEditing(true)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "backToSettings" {
            return true
        }
        else {
            if let _ = imagePicker?.image {
                if let text = returnImageName() {
                    //folder stuff
                    let image = scaleDownImage(imagePicker.image!)
                    let tile = Tile(tileName: text, tileImage: image, folderName: returnFolderName())
                    data.addTile(tile)
                    return true
                }
                else {
                    notifyUserOfError("Icon must have both an Image and a Name", popUpMessage: "Please add the name of the Image to the 'Image Name' box", popUpButtonLabel: "Okay")
                    return false
                }
            }
            else {
                notifyUserOfError("Icon must have both an Image and a Name", popUpMessage: "Please add a photo by using the 'Take Photo' option, or by selecting an image from your device's Library", popUpButtonLabel: "Okay")
                return false
            }
        }
    }
}
