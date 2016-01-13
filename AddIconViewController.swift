//
//  SettingsModalViewController.swift
//  Glyph

import UIKit
import Foundation

class AddIconViewController: UITableViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    var data = DataModel(isNewEmptyDataModel: false)
    
    // delete when we get folders working
    var folders: [String] = NSUserDefaults.standardUserDefaults().arrayForKey("folders") as? [String] ?? ["General"]
    
    
    @IBOutlet weak var folderTextField: UITextField!
    // Image View attribute
    @IBOutlet var imagePicker: UIImageView!
    
    @IBOutlet weak var previewLabel: UILabel!
   
    var img: UIImage?
    
    @IBOutlet weak var addButton: UIButton!
    
    let picker = UIImagePickerController()
    
    // Text Field for User to add Picture Label
    @IBOutlet var textField: UITextField!
    
    @IBAction func shootPhoto(sender: UIButton) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            presentViewController(picker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    
    
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
    
    // Alert if device doesn't have camera button
    func noCamera(){
        let alertVC = UIAlertController(title: "Camera Feature Not Available", message: "This device does not have a camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }

    @IBAction func textEdited(sender: UITextField) {
        previewLabel.text = sender.text
    }
    
    @IBAction func chooseFromLibrary(sender: UIButton) {
        // tells the picker to include all of the photo, not an edited portion
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        // creates a pop-over image-picker. (necessary for iPad)
        picker.modalPresentationStyle = .Popover
        presentViewController(picker, animated: true, completion: nil)//4
        // reference rectangle to view from (uses the bar button item)
        picker.popoverPresentationController?.sourceView = sender
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        let folderPicker = UIPickerView()
        folderPicker.dataSource = self
        folderPicker.delegate = self
        self.folderTextField.inputView = folderPicker
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
    
    //MARK: Image Picker Delegate Methods
    func scaleImageWith(newImage:UIImage, and newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        newImage.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
     // taken from http://stackoverflow.com/questions/27833075/swift-uilabel-programmatically-updates-after-uibutton-pressed
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let pickedImage: UIImage = (info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as! UIImage
    
        let sizeOfImageView:CGRect = imagePicker.frame
      
        imagePicker.frame = sizeOfImageView
        imagePicker.image = pickedImage
        img = imagePicker.image
        picker.dismissViewControllerAnimated(true, completion: nil)
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
        self.folderTextField.text = self.folders[row];
        self.folderTextField.endEditing(true)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "backToSettings" {
            return true
        }
        else {
            if let _ = imagePicker?.image {
                if let text = returnImageName() {
                    //folder stuff
                    data.add(imagePicker.image!, label: text, folder: returnFolderName())
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